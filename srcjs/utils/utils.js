export function convertToDateString(dateInput) {
  if(dateInput === null) return null;

  // Extract the year, month, and day
  const year = dateInput.getFullYear();
  const month = String(dateInput.getMonth() + 1).padStart(2, '0');
  const day = String(dateInput.getDate()).padStart(2, '0');

  // Format the date into "yyyy-mm-dd"
  const formattedDate = `${year}-${month}-${day}`;

  return formattedDate;
}
