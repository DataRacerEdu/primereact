import { reactShinyInput } from 'reactR';
import React, { useState, useEffect } from "react";
import { SelectButton } from 'primereact/selectbutton';

const ToggleTextButtonInput = ({ configuration, value, setValue }) => {
  const [itemOptions, setItemOptions] = useState(null);
  const [lang_selected, setlang_selected] = useState(configuration.default_langauge); //

  // Register the Shiny custom message handler for 'language_changed'
  useEffect(() => {
    if (window.Shiny) {
      Shiny.addCustomMessageHandler(configuration.message_handler_id_from_shiny, function(newLanguage) {
        console.log("Language change trigger received:", newLanguage);
        setlang_selected(newLanguage);
      });
    }
  }, []);

  // Render options
  useEffect(() => {
    // Dynamically create `itemOptions`
    const itemOptions = configuration.options.map(value => ({
        value: value,
        name: configuration.translation_list[lang_selected][value] || value, // Fallback to `value` if no translation
    }));
    setItemOptions(itemOptions);
  }, [lang_selected]);

  return (
    <div className="card flex justify-content-center">
      <SelectButton
        value={value.value}
        onChange={(e) => {
          setValue({value: e.value, name: configuration.translation_list[lang_selected][e.value]});
        }}
        optionLabel="name"
        options={itemOptions}
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
