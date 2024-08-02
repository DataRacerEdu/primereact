import { reactShinyInput } from 'reactR';
import React, { useState, useEffect } from "react";
import { Calendar } from 'primereact/calendar';
import "primereact/resources/themes/lara-light-cyan/theme.css";
import { convertToDateString } from "./utils/utils.js";


const DateRangeInput = ({ configuration, value, setValue }) => {
  let res = value ? value.map(date => new Date(date)) : null;
  const [dates, setDates] = useState(res);

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

