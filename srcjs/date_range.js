import { reactShinyInput } from 'reactR';
import React, { useState, useEffect } from "react";
import { Calendar } from 'primereact/calendar';
import "primereact/resources/themes/lara-light-cyan/theme.css";
import { convertToDateString } from "./utils/utils.js";


const DateRangeInput = ({ configuration, value, setValue }) => {
  const [dates, setDates] = useState(value ? value.map(date => new Date(date)) : null);

  useEffect(() => {
    if (value) {
      setDates(value.map(date => new Date(date)));
      return;
    }

    if(!value) {
      setDates(null);
      return;
    }
  }, [value]);

  useEffect(() => {
    console.log("dates:");
    console.log(dates);
  }, [dates]);

  return (
    <div className="card flex justify-content-center">
      <Calendar
        value={dates}
        onChange={(e) => setDates((e.value))}
        onHide={() => setValue(dates ? dates.map(date => convertToDateString(date)) : [null, null])}
        selectionMode="range"
        readOnlyInput
        hideOnRangeSelection
        showButtonBar
        placeholder={configuration.placeholder || "Select Date Range"}
        showIcon
        showMinMaxRange
        className={`${configuration.class || ''} w-full`} // Properly handle the className
        {...(configuration.minDate ? { minDate: new Date(configuration.minDate) } : {})} // Apply the width prop if it
        {...(configuration.maxDate ? { maxDate: new Date(configuration.maxDate) } : {})}
        {...(configuration.width ? { style: { width: configuration.width } } : {})} // Apply the width prop if it exists, else no style
      />
    </div>
  )
};

export default function initDateRangeInput(){
  return reactShinyInput(
    '.date_range',
    'primereact.date_range',
    DateRangeInput
  );
}

