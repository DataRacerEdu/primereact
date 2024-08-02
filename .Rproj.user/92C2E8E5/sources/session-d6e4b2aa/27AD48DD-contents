import { reactShinyInput } from 'reactR';
import { Dropdown } from "primereact/dropdown";
import { useState, useEffect } from "react";
import "primereact/resources/themes/lara-light-cyan/theme.css";
import { withIconTemplate, selectedWithIconTemplate } from "./utils/selectIconTemplate.js";


const SelectInput = ({ configuration, value, setValue }) => {

  return (
    <Dropdown
      value={value}
      onChange={(e) => e.value === undefined ? setValue(null) : setValue(e.value)}
      options={configuration.options || []}
      optionLabel="title"
      showClear
      placeholder={configuration.placeholder || "Select value"}
      className={`${configuration.class || ''} w-full`} // Properly handle the className
      {...(configuration.width ? { style: { width: configuration.width } } : {})} // Apply the width prop if it exists, else
      {...(configuration.iconClass ? { itemTemplate: (option) => withIconTemplate(option, configuration.iconClass)  } : {})}
      {...(configuration.iconClass ? { valueTemplate: (option) => selectedWithIconTemplate(option, configuration.iconClass, configuration.placeholder)  } : {})}
      />
  );
};

export default function initSelectInput() {
  return reactShinyInput(
    '.select',
    'primereact.select',
    SelectInput
  );
}
