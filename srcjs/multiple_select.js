import { reactShinyInput } from 'reactR';
import { useState, useEffect } from "react";
import { MultiSelect } from 'primereact/multiselect';
import "primereact/resources/themes/lara-light-cyan/theme.css";
import { withIconTemplate } from "./utils/selectIconTemplate.js";


const MultiSelectDropdown = ({ configuration, value, setValue }) => {
  return (
    <div className="card flex justify-content-center">
      <MultiSelect
        value={value}
        options={configuration.options || []}
        onChange={(e) => e.value === undefined || e.value.length < 1 ? setValue(null) : setValue(e.value)}
        optionLabel="title"
        placeholder={configuration.placeholder || "Select value(s)"}
        className={`${configuration.class || ''} w-full`} // Properly handle the className
        {...(configuration.width ? { style: { width: configuration.width } } : {})} // Apply the width prop if it exists, else
        {...(configuration.iconClass ? { itemTemplate: (option) => withIconTemplate(option, configuration.iconClass)  } : {})}
        display="chip"
      />
    </div>
  );
};

export default function initMultiSelectInput() {
  return reactShinyInput(
    '.multiple_select',
    'primereact.multiple_select',
    MultiSelectDropdown
  );
}
