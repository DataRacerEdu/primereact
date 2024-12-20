import { reactShinyInput } from 'reactR';
import { useState, useEffect } from "react";
import { MultiSelect } from 'primereact/multiselect';
import "primereact/resources/themes/lara-light-cyan/theme.css";
import { withIconTemplate } from "./utils/selectIconTemplate.js";


const MultiSelectDropdown = ({ configuration, value, setValue }) => {
  const [lang_selected, setlang_selected] = useState(configuration.default_langauge);
  const [placeholder, setPlaceholder] = useState(configuration.placeholder);

  // Register the Shiny custom message handler for 'language_changed'
  useEffect(() => {
    if (window.Shiny) {
      Shiny.addCustomMessageHandler(configuration.message_handler_id_from_shiny, function(newLanguage) {
        setlang_selected(newLanguage);
      });
    }
  }, []);

  // Render placeholder
  useEffect(() => {
    // Dynamically create translate text
    const translated_text = configuration.translation_list[lang_selected][configuration.placeholder] || configuration.placeholder; // Fallback to `value` if no translation
    setPlaceholder(translated_text);
  }, [lang_selected]);


  return (
    <div className="card flex justify-content-center">
      <MultiSelect
        value={value}
        options={configuration.options || []}
        onChange={(e) => e.value === undefined || e.value.length < 1 ? setValue(null) : setValue(e.value)}
        optionLabel="title"
        placeholder={placeholder || "Select value(s)"}
        className={`${configuration.class || ''} w-full`} // Properly handle the className
        {...(configuration.width ? { style: { width: configuration.width } } : {})} // Apply the width prop if it exists, else
        {...(configuration.iconClass ? { itemTemplate: (option) => withIconTemplate(option, configuration.iconClass)  } : {})}
        display="chip"
        filter={configuration.filter}
        filterInputAutoFocus={configuration.filterInputAutoFocus}
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
