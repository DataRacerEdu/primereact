export function parseDateString(value) {
  if (value == null) return null;
  if (value instanceof Date) return isNaN(value.getTime()) ? null : value;

  // "yyyy-mm-dd" must be parsed as local midnight, not UTC midnight,
  // to mirror convertToDateString's local getters
  const m = /^(\d{4})-(\d{2})-(\d{2})/.exec(String(value));
  if (!m) {
    const d = new Date(value);
    return isNaN(d.getTime()) ? null : d;
  }
  return new Date(+m[1], +m[2] - 1, +m[3]);
}

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
