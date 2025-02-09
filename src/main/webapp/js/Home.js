


function viewNews(newsId) {
    window.location.href = 'News?id=' + newsId;
}
// Enable/disable return date based on trip type
document.getElementById('oneWay').addEventListener('change', function () {
    document.getElementById('returnDate').disabled = true;
});
document.getElementById('roundTrip').addEventListener('change', function () {
    document.getElementById('returnDate').disabled = false;
});


// Passenger dropdown logic
const passengerBtn = document.getElementById('passengerBtn');
const passengerDropdown = document.getElementById('passengerDropdown');


passengerBtn.addEventListener('click', function () {
    passengerDropdown.style.display = passengerDropdown.style.display === 'block' ? 'none' : 'block';
});


function closePassengerDropdown() {
    passengerDropdown.style.display = 'none';
    const adultCount = document.getElementById('adultCount').textContent;
    const childCount = document.getElementById('childCount').textContent;
    const infantCount = document.getElementById('infantCount').textContent;
    const total = parseInt(adultCount) + parseInt(childCount) + parseInt(infantCount);


    passengerBtn.querySelector('span').textContent = `${total} người`;


    // Cập nhật input ẩn
    document.getElementById('totalPassengers').value = total;
}


function adjustPassenger(type, change) {
    const countElement = document.getElementById(`${type}Count`);
    let count = parseInt(countElement.textContent);
    count = Math.max(0, count + change);
    countElement.textContent = count;
}


// Close dropdown when clicking outside
document.addEventListener('click', function (event) {
    if (!passengerBtn.contains(event.target) && !passengerDropdown.contains(event.target)) {
        passengerDropdown.style.display = 'none';
    }
});

