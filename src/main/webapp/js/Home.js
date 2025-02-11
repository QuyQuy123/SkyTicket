


function viewNews(newsId) {
    window.location.href = 'NewsURL?id=' + newsId;
}

const passengersInput = document.getElementById('passengers');
const adultCountInput = document.getElementById('adult-count');
const childCountInput = document.getElementById('child-count');
const infantCountInput = document.getElementById('infant-count');
const passengerOptionsDiv = document.getElementById('passenger-options');

//

// Function to update total passengers
function updateTotalPassengers() {
    const adults = parseInt(adultCountInput.value) || 0;
    const children = parseInt(childCountInput.value) || 0;
    const infants = parseInt(infantCountInput.value) || 0;
    const totalPassengers = adults + children + infants;
    passengersInput.value = totalPassengers;

    if (infants > adults) {
        alert("The number of infants cannot exceed the number of adults.");
        infantCountInput.value = adults;
        passengersInput.value -= 1;
        return;
    }

    if (totalPassengers > 10) {
        alert("Total passengers cannot exceed 10.");
        passengersInput.value = 10;
        return;
    }
}

adultCountInput.addEventListener('input', updateTotalPassengers);
childCountInput.addEventListener('input', updateTotalPassengers);
infantCountInput.addEventListener('input', updateTotalPassengers);

// Show passenger options when clicking on the input
passengersInput.addEventListener('click', function (event) {
    event.stopPropagation();
    passengerOptionsDiv.style.display = 'block';
});

passengerOptionsDiv.addEventListener('click', function (event) {
    event.stopPropagation();
});

// Hide options when clicking outside
document.addEventListener('click', function (event) {
    if (!passengerOptionsDiv.contains(event.target) && event.target !== passengersInput) {
        passengerOptionsDiv.style.display = 'none';
    }
});

function showLocationList(inputId) {
    hideAllLocationLists();
    document.getElementById(inputId + '-locations').style.display = 'block';
}

function hideAllLocationLists() {
    document.querySelectorAll('.location-list').forEach(list => {
        list.style.display = 'none';
    });
}

function selectLocation(locationId, displayText, inputId) {
    document.getElementById(inputId + 'Display').value = displayText;
    document.getElementById(inputId).value = locationId;
    document.getElementById(inputId + '-locations').style.display = 'none';
}

// Other existing functions remain unchanged...


// Filter locations based on input value
function filterLocations(type) {
    const input = document.getElementById(type + 'Display');
    const filter = input.value.toLowerCase();
    const locationList = document.getElementById(type + '-locations');
    const items = locationList.getElementsByClassName('location-item');

    // Loop through all items and hide those that don't match the input
    for (let i = 0; i < items.length; i++) {
        const txtValue = items[i].textContent || items[i].innerText;
        if (txtValue.toLowerCase().indexOf(filter) > -1) {
            items[i].style.display = "";
        } else {
            items[i].style.display = "none";
        }
    }

    // Show the location list only if there are items visible
    if (filter.length > 0) {
        locationList.style.display = 'block';
    } else {
        locationList.style.display = 'none';
    }
}


//
function filterLocations() {
    var input = document.getElementById("searchLocation");
    var filter = input.value.toLowerCase();
    var items = document.getElementsByClassName("location-item");

    for (var i = 0; i < items.length; i++) {
        var locationName = items[i].getElementsByClassName("location-name")[0].innerText.toLowerCase();
        var airportName = items[i].getElementsByClassName("airport-name")[0].innerText.toLowerCase();

        if (locationName.includes(filter) || airportName.includes(filter)) {
            items[i].style.display = "";
        } else {
            items[i].style.display = "none";
        }
    }
}





// Hide the list if the user clicks outside of the input or list
document.addEventListener('click', function (event) {
    // If the clicked element is not an from or to or part of the location list, hide all lists
    if (!event.target.closest('.location-list') && !event.target.closest('#fromDisplay') && !event.target.closest('#toDisplay')) {
        document.querySelectorAll('.location-list').forEach(list => {
            list.style.display = 'none';
        });
    }
});
function validateLocations(event) {
    const departure = document.getElementById('fromDisplay').value;
    const destination = document.getElementById('toDisplay').value;
    const errorMessageElement = document.getElementById('errorMessage');

    // Check if departure and destination are the same
    if (departure === destination) {
        event.preventDefault(); // Prevent form submission

        // Display error message
        errorMessageElement.textContent = "Duplicate departure and destination";
        errorMessageElement.style.color = "red";

        return false; // Prevent the form from submitting
    }

    // Clear the error message if validation passes
    errorMessageElement.textContent = "";
    return true; // Allow form submission if locations are different
}
function toggleReturnDate() {
    const returnDateField = document.getElementById("returnDateField");
    const returnDateInput = document.getElementById("returnDate");
    const flightType = document.querySelector('input[name="flightType"]:checked').value; // Get the value of the selected trip type
    const passengerField = document.getElementById("passengerField");

    // If "Khứ hồi" is selected, display the "Ngày về" field
    if (flightType === "roundTrip") {
        returnDateField.style.display = "block";
        passengerField.className = "col-md-2"; // Set passengers field to col-md-2
        returnDateInput.setAttribute("required", "required");
    } else if (flightType === "oneWay") {
        returnDateField.style.display = "none";
        passengerField.className = "col-md-4"; // Set passengers field to col-md-4
        returnDateInput.removeAttribute("required");
    }
}
$(document).ready(function () {
    // Get today's date
    var today = new Date();
    var formattedToday = today.getFullYear() + '-' +
        ('0' + (today.getMonth() + 1)).slice(-2) + '-' +
        ('0' + today.getDate()).slice(-2);

    // Initialize datepicker for departureDate
    $('#departureDate').datepicker({
        format: 'dd-mm-yyyy',
        // format: 'yyyy-mm-dd', // Custom date format
        autoclose: true, // Automatically close the calendar after picking a date
        todayHighlight: true, // Highlight today's date
        orientation: 'bottom auto', // Ensure the calendar pops up below the input
        startDate: formattedToday // Minimum date is 01/10/2024
    }).on('changeDate', function (selected) {
        // Get the selected departure date
        var minReturnDate = new Date(selected.date.valueOf());
        minReturnDate.setDate(minReturnDate.getDate()); // Set the return date to be at least one day after the departure

        // Set the minimum date for returnDate
        $('#returnDate').datepicker('setStartDate', minReturnDate);
        // If return date is before the new minimum, clear it
        if ($('#returnDate').datepicker('getDate') && $('#returnDate').datepicker('getDate') < minReturnDate) {
            $('#returnDate').datepicker('clearDates');
        }
    });

    // Initialize datepicker for returnDate
    $('#returnDate').datepicker({
        format: 'dd-mm-yyyy', // Custom date format
        autoclose: true, // Automatically close the calendar after picking a date
        todayHighlight: true, // Highlight today's date
        orientation: 'bottom auto', // Ensure the calendar pops up below the input
        startDate: formattedToday // Default minimum date for return (will change based on departure)
    });
});

// Call toggleReturnDate on page load to handle default states
document.addEventListener('DOMContentLoaded', toggleReturnDate);
document.addEventListener("DOMContentLoaded", function () {
    // Kiểm tra nếu URL có chứa "#contactSection"
    if (window.location.hash === "#contactSection") {
        document.getElementById("contactSection").scrollIntoView({ behavior: "smooth" });
    }
});
// Ensure to bind the toggleReturnDate to the radio buttons' change event
document.getElementById("oneWay").addEventListener('change', toggleReturnDate);
document.getElementById("roundTrip").addEventListener('change', toggleReturnDate);
function validateDates() {
    const departureDate = document.getElementById('departureDate').value;
    const returnDate = document.getElementById('returnDate').value;

    // Proceed only if both dates are provided
    if (departureDate && returnDate) {
        const depDate = new Date(departureDate);
        const retDate = new Date(returnDate);

        // Check if the departure date is after the return date
        if (depDate > retDate) {
            event.preventDefault();
            alert("Ngày đi phải trước ngày về.");
            return false; // Prevent form submission
        }
    }

    // Allow form submission if validation passes
    return true;
}

// Optional: Toggle the return date field based on departure date selection
document.getElementById('departureDate').addEventListener('change', function () {
    const returnDateField = document.getElementById('returnDateField');
    returnDateField.style.display = this.value ? 'block' : 'none';
});


