import { reactShinyInput } from 'reactR';
import { useState, useEffect } from "react";
import { Button } from 'primereact/button';
import 'primeicons/primeicons.css';
import "primereact/resources/themes/lara-light-cyan/theme.css";

const ActionButtonInput = ({ configuration, value, setValue }) => {
  const [lang_selected, setlang_selected] = useState(configuration.default_langauge);
  const [placeholder, setPlaceholder] = useState(configuration.label);

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
    const translated_text = configuration.translation_list[lang_selected][configuration.label] || configuration.label; // Fallback to `value` if no translation
    setPlaceholder(translated_text);
  }, [lang_selected]);

  return (
    <div className="card flex justify-content-center">
      <Button
        label={placeholder}
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

