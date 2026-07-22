import React from 'react';
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { DateRangeInput } from '../date_range.js';

const baseConfig = {
  placeholder: 'Select Date Range'
};

const renderDateRange = (configOverrides = {}, value = null) => {
  const setValue = jest.fn();
  const utils = render(
    <DateRangeInput
      configuration={{ ...baseConfig, ...configOverrides }}
      value={value}
      setValue={setValue}
    />
  );
  const input = screen.getByPlaceholderText('Select Date Range');
  return { setValue, input, ...utils };
};

describe('DateRangeInput', () => {
  test('renders a readonly input by default (readonly not set)', () => {
    const { input } = renderDateRange();
    expect(input).toHaveAttribute('readonly');
  });

  test('renders an editable input when config.readonly is false', () => {
    const { input } = renderDateRange({ readonly: false });
    expect(input).not.toHaveAttribute('readonly');
  });

  test('typing a full range and closing the calendar commits both dates', async () => {
    const user = userEvent.setup();
    const { input, setValue } = renderDateRange({ readonly: false });

    await user.click(input);
    await user.type(input, '07/01/2026 - 07/10/2026');
    await user.keyboard('{Escape}');

    await waitFor(() => {
      expect(setValue).toHaveBeenCalledWith(['2026-07-01', '2026-07-10']);
    });
  });

  test('typing cannot happen when readonly (the default)', async () => {
    const user = userEvent.setup();
    const { input } = renderDateRange();

    await user.click(input);
    await user.type(input, '07/01/2026 - 07/10/2026');
    expect(input).toHaveValue('');
  });

  test('incomplete range does not commit dates', async () => {
    const user = userEvent.setup();
    const { input, setValue } = renderDateRange({ readonly: false });

    await user.click(input);
    await user.type(input, '07/01/2026');
    await user.keyboard('{Escape}');

    await waitFor(() => {
      expect(setValue).toHaveBeenCalled();
    });
    expect(setValue).toHaveBeenCalledWith([null, null]);
  });

  test('initial value from Shiny is shown formatted', () => {
    const { input } = renderDateRange({}, ['2026-03-05', '2026-03-10']);
    expect(input).toHaveValue('03/05/2026 - 03/10/2026');
  });

  test('config.dateFormat changes the display format', () => {
    const { input } = renderDateRange({ dateFormat: 'dd.mm.yy' }, ['2026-03-05', '2026-03-10']);
    expect(input).toHaveValue('05.03.2026 - 10.03.2026');
  });

  test('typing a range follows config.dateFormat and commits yyyy-mm-dd', async () => {
    const user = userEvent.setup();
    const { input, setValue } = renderDateRange({ readonly: false, dateFormat: 'dd.mm.yy' });

    await user.click(input);
    await user.type(input, '01.07.2026 - 10.07.2026');
    await user.keyboard('{Escape}');

    await waitFor(() => {
      expect(setValue).toHaveBeenCalledWith(['2026-07-01', '2026-07-10']);
    });
  });
});
