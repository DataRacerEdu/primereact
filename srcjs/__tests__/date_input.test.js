import React from 'react';
import { render, screen, waitFor, fireEvent } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { DateInput } from '../date_input.js';

const baseConfig = {
  placeholder: 'Select Date'
};

const renderDateInput = (configOverrides = {}, value = null) => {
  const setValue = jest.fn();
  const utils = render(
    <DateInput
      configuration={{ ...baseConfig, ...configOverrides }}
      value={value}
      setValue={setValue}
    />
  );
  const input = screen.getByPlaceholderText('Select Date');
  return { setValue, input, ...utils };
};

describe('DateInput', () => {
  test('renders a readonly input by default (readonly not set)', () => {
    const { input } = renderDateInput();
    expect(input).toHaveAttribute('readonly');
  });

  test('renders an editable input when config.readonly is false', () => {
    const { input } = renderDateInput({ readonly: false });
    expect(input).not.toHaveAttribute('readonly');
  });

  test('typing a full date and closing the calendar commits yyyy-mm-dd to Shiny', async () => {
    const user = userEvent.setup();
    const { input, setValue } = renderDateInput({ readonly: false });

    await user.click(input);
    await user.type(input, '07/15/2026');
    expect(input).toHaveValue('07/15/2026');

    await user.keyboard('{Escape}');

    await waitFor(() => {
      expect(setValue).toHaveBeenCalledWith('2026-07-15');
    });
  });

  test('typing cannot happen when readonly (the default)', async () => {
    const user = userEvent.setup();
    const { input, setValue } = renderDateInput();

    await user.click(input);
    await user.type(input, '07/15/2026');
    expect(input).toHaveValue('');

    await user.keyboard('{Escape}');
    await waitFor(() => {
      expect(setValue).toHaveBeenCalledWith(null);
    });
  });

  test('invalid typed text does not commit a date', async () => {
    const user = userEvent.setup();
    const { input, setValue } = renderDateInput({ readonly: false });

    await user.click(input);
    await user.type(input, 'not a date');
    await user.keyboard('{Escape}');

    await waitFor(() => {
      expect(setValue).toHaveBeenCalled();
    });
    expect(setValue).toHaveBeenCalledWith(null);
    expect(setValue).not.toHaveBeenCalledWith(expect.stringMatching(/^\d{4}-\d{2}-\d{2}$/));
  });

  test('partial input does not jump the value to a spurious date', async () => {
    const user = userEvent.setup();
    const { input, setValue } = renderDateInput({ readonly: false });

    await user.click(input);
    await user.type(input, '12');
    await user.keyboard('{Escape}');

    await waitFor(() => {
      expect(setValue).toHaveBeenCalled();
    });
    // "12" must not be interpreted as e.g. Dec 2001 by new Date()
    expect(setValue).not.toHaveBeenCalledWith(expect.stringMatching(/^\d{4}-\d{2}-\d{2}$/));
  });

  test('initial value from Shiny is shown formatted as mm/dd/yyyy', () => {
    const { input } = renderDateInput({}, '2026-03-05');
    expect(input).toHaveValue('03/05/2026');
  });

  test('config.dateFormat changes the display format', () => {
    const { input } = renderDateInput({ dateFormat: 'dd.mm.yy' }, '2026-03-05');
    expect(input).toHaveValue('05.03.2026');
  });

  test('typing follows config.dateFormat and still commits yyyy-mm-dd', async () => {
    const user = userEvent.setup();
    const { input, setValue } = renderDateInput({ readonly: false, dateFormat: 'dd.mm.yy' });

    await user.click(input);
    await user.type(input, '15.07.2026');
    await user.keyboard('{Escape}');

    await waitFor(() => {
      expect(setValue).toHaveBeenCalledWith('2026-07-15');
    });
  });

  test('typed input not matching config.dateFormat does not commit', async () => {
    const user = userEvent.setup();
    const { input, setValue } = renderDateInput({ readonly: false, dateFormat: 'dd.mm.yy' });

    await user.click(input);
    await user.type(input, '07/15/2026');
    await user.keyboard('{Escape}');

    await waitFor(() => {
      expect(setValue).toHaveBeenCalled();
    });
    expect(setValue).not.toHaveBeenCalledWith(expect.stringMatching(/^\d{4}-\d{2}-\d{2}$/));
  });

  test('picking a date from the popup works in default readonly mode', async () => {
    const user = userEvent.setup();
    const { input, setValue } = renderDateInput({}, '2026-07-01');

    await user.click(input);
    // Pick the 20th of the displayed month (July 2026). fireEvent instead of
    // userEvent: userEvent's pointer sequence trips the overlay's
    // outside-click detection under jsdom.
    const day = await screen.findByText('20', { selector: 'span' });
    fireEvent.click(day);

    // Single-select auto-hides the overlay, which commits the value
    await waitFor(() => {
      expect(setValue).toHaveBeenCalledWith('2026-07-20');
    });
  });
});
