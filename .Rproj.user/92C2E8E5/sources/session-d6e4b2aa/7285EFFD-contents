import { reactShinyInput } from 'reactR';
import React, { useState } from "react";
import { ToggleButton } from 'primereact/togglebutton';


const ToggleButtonInput = ({ configuration, value, setValue }) => {

  return (
    <div className="card flex justify-content-center">
      <ToggleButton
        onLabel={configuration.onLabel || 'On'}
        offLabel={configuration.offLabel || 'Off'}
        onIcon={configuration.onIcon || 'pi pi-check'}
        offIcon={configuration.offIcon || 'pi pi-times'}
        checked={value}
        onChange={(e) => setValue(e.value)}
        className={`${configuration.class || ''} w-9rem`} // Properly handle the className
        {...(configuration.width ? { style: { width: configuration.width } } : {})} // Apply the width prop if it exists, else no style
      />
    </div>
  );
};

export default function initToggleButtonInput(){
  return reactShinyInput(
    '.toggle_button',
    'primereact.toggle_button',
    ToggleButtonInput
  );
}
