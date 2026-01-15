import { reactShinyInput } from 'reactR';
import React, { useState, useEffect } from "react";
import { ToggleButton } from 'primereact/togglebutton';


const ToggleButtonInput = ({ configuration, value, setValue }) => {
  // Store merged configuration in state for partial updates
  const [config, setConfig] = useState(() => ({ ...configuration }));

  // Merge incoming configuration updates (supports partial updates)
  useEffect(() => {
    if (!configuration) return;
    setConfig(prev => {
      const merged = { ...prev };
      for (const key in configuration) {
        if (configuration[key] !== undefined) {
          merged[key] = configuration[key];
        }
      }
      return merged;
    });
  }, [JSON.stringify(configuration)]);

  return (
    <div className="card flex justify-content-center">
      <ToggleButton
        onLabel={config.onLabel || 'On'}
        offLabel={config.offLabel || 'Off'}
        onIcon={config.onIcon || 'pi pi-check'}
        offIcon={config.offIcon || 'pi pi-times'}
        disabled={config.disabled}
        checked={value}
        onChange={(e) => setValue(e.value)}
        className={`${config.class || ''} w-9rem`}
        {...(config.width ? { style: { width: config.width } } : {})}
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
