import { reactShinyInput } from 'reactR';
import React, { useState } from "react";
import { SelectButton } from 'primereact/selectbutton';

const ToggleTextButtonInput = ({ configuration, value, setValue }) => {
  console.log("Component")

  return (
    <div className="card flex justify-content-center">
      <SelectButton
        value={value}
        onChange={(e) => setValue(e.value)}
        options={configuration.options}
        allowEmpty={false}
        multiple={false}
      />
    </div>
  );
};

export default function initToggleTextButtonInput(){
  return reactShinyInput(
    '.toggle_text_button',
    'primereact.toggle_text_button',
    ToggleTextButtonInput
  );
}
