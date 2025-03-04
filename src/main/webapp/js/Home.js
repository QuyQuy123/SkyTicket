


function viewNews(newsId) {
    window.location.href = 'NewsURL?id=' + newsId;
}

const passengersInput = document.getElementById('passengers');
const adultCountInput = document.getElementById('adult-count');
const childCountInput = document.getElementById('child-count');
const infantCountInput = document.getElementById('infant-count');
const passengerOptionsDiv = document.getElementById('passenger-options');

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


passengersInput.addEventListener('click', function (event) {
    event.stopPropagation();
    passengerOptionsDiv.style.display = 'block';
});

passengerOptionsDiv.addEventListener('click', function (event) {
    event.stopPropagation();
});


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

function filterLocations(eventOrType) {
    let input, filter, locationList, items, type;

    // Xác định nguồn sự kiện
    if (typeof eventOrType === 'object' && eventOrType.target) {
        // Gọi từ onkeyup (ô tìm kiếm)
        input = eventOrType.target;
        if (input.id === 'searchLocation1') {
            type = 'from';
        } else if (input.id === 'searchLocation2') {
            type = 'to';
        }
    } else {
        // Gọi từ oninput (fromDisplay hoặc toDisplay)
        type = eventOrType; // 'from' hoặc 'to'
        input = document.getElementById(type + 'Display');
    }

    // Kiểm tra nếu input tồn tại
    if (!input) {
        console.error('Input element not found for type: ' + type);
        return;
    }

    filter = input.value.toLowerCase();
    locationList = document.getElementById(type + '-locations');

    // Kiểm tra nếu locationList tồn tại
    if (!locationList) {
        console.error('Location list not found for type: ' + type);
        return;
    }

    items = locationList.getElementsByClassName('location-item');

    // Lọc danh sách
    for (let i = 0; i < items.length; i++) {
        const txtValue = items[i].textContent || items[i].innerText;
        if (txtValue.toLowerCase().indexOf(filter) > -1) {
            items[i].style.display = "";
        } else {
            items[i].style.display = "none";
        }
    }

    // Hiển thị hoặc ẩn danh sách
    if (filter.length > 0) {
        locationList.style.display = 'block';
    } else {
        locationList.style.display = 'none';
    }
}


document.addEventListener('click', function (event) {
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

       if (departure === destination) {
        event.preventDefault();
        errorMessageElement.textContent = "Duplicate departure and destination";
        errorMessageElement.style.color = "red";

        return false;
    }

    errorMessageElement.textContent = "";
    return true;
}
function toggleReturnDate() {
    const returnDateField = document.getElementById("returnDateField");
    const returnDateInput = document.getElementById("returnDate");
    const flightType = document.querySelector('input[name="flightType"]:checked').value;
    const passengerField = document.getElementById("passengerField");

    if (flightType === "roundTrip") {
        returnDateField.style.display = "block";
        passengerField.className = "col-md-2";
        returnDateInput.setAttribute("required", "required"); // Thêm required
    } else if (flightType === "oneWay") {
        returnDateField.style.display = "none";
        passengerField.className = "col-md-4";
        returnDateInput.removeAttribute("required"); // Gỡ bỏ required
        returnDateInput.value = ""; // Reset giá trị ngày về
    }
}
document.getElementById("searchForm").addEventListener("submit", function(event) {
    const returnDateInput = document.getElementById("returnDate");

    if (returnDateInput.style.display === "none" || returnDateInput.hidden) {
        returnDateInput.removeAttribute("required"); // Chắc chắn đã bỏ required
    }
});



document.addEventListener('DOMContentLoaded', toggleReturnDate);
document.addEventListener("DOMContentLoaded", function () {

    if (window.location.hash === "#contactSection") {
        document.getElementById("contactSection").scrollIntoView({ behavior: "smooth" });
    }
})

document.addEventListener('DOMContentLoaded', function () {
    toggleReturnDate();

    document.querySelectorAll('input[name="flightType"]').forEach(radio => {
        radio.addEventListener('change', toggleReturnDate);
    });
});



document.getElementById("oneWay").addEventListener('change', toggleReturnDate);
document.getElementById("roundTrip").addEventListener('change', toggleReturnDate);

function validateDates() {
    const departureDate = document.getElementById('departureDate').value;
    const returnDate = document.getElementById('returnDate').value;
    if (departureDate && returnDate) {
        const depDate = new Date(departureDate);
        const retDate = new Date(returnDate);
        if (depDate > retDate) {
            event.preventDefault();
            alert("Ngày đi phải trước ngày về.");
            return false;
        }
    }
    return true;
}


document.getElementById('departureDate').addEventListener('change', function () {
    const returnDateField = document.getElementById('returnDateField');
    returnDateField.style.display = this.value ? 'block' : 'none';
});


