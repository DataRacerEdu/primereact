import { reactShinyInput } from 'reactR';
import { useState } from "react";
import { Button } from 'primereact/button';
import 'primeicons/primeicons.css';
import "primereact/resources/themes/lara-light-cyan/theme.css";

const ActionButtonInput = ({ configuration, value, setValue }) => {
  return (
    <div className="card flex justify-content-center">
      <Button
        label={configuration.label}
        icon={configuration.icon}
        iconPos={configuration.iconPos}
        disabled={configuration.disabled}
        rounded={configuration.rounded}
        text={configuration.text}
        raised={configuration.raised}
        outlined={configuration.outlined}
        size={configuration.size}
        onClick={() => setValue(value + 1)}
      />
    </div>
  )
};

export default function initActionButton(){
  return reactShinyInput(
    '.action_button',
    'primereact.action_button',
    ActionButtonInput);
}

