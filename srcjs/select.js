import { reactShinyInput } from 'reactR';
import { Dropdown } from "primereact/dropdown";
import { useState, useEffect } from "react";
import "primereact/resources/themes/lara-light-cyan/theme.css";
import { withIconTemplate, selectedWithIconTemplate } from "./utils/selectIconTemplate.js";


const SelectInput = ({ configuration, value, setValue }) => {
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
    <Dropdown
      value={value}
      onChange={(e) => e.value === undefined ? setValue(null) : setValue(e.value)}
      options={configuration.options || []}
      optionLabel="title"
      showClear
      placeholder={placeholder || "Select value"}
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
