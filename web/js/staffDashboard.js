document.addEventListener('DOMContentLoaded', () => {
    // Select the toggle button using its class
    const toggleBtn = document.querySelector('.toggle-btn');

    // Check if the toggle button exists before proceeding
    if (toggleBtn) {
        // Select the sidebar and content elements
        const sidebar = document.getElementById('sidebar');
        const content = document.getElementById('content');

        // Add the click event listener to toggle the sidebar and content visibility
        toggleBtn.addEventListener('click', () => {
            sidebar.classList.toggle('active');
            content.classList.toggle('active');
        });
    }

    // Notification Bell Click Event
    document.getElementById('notificationBell').addEventListener('click', function () {
        const notificationBox = document.getElementById('notificationBox');
        notificationBox.style.display = (notificationBox.style.display === 'block') ? 'none' : 'block';
    });

    // Close notification box when clicking outside
    document.addEventListener('click', function (e) {
        const box = document.getElementById('notificationBox');
        const bell = document.getElementById('notificationBell');
        if (!box.contains(e.target) && !bell.contains(e.target)) box.style.display = 'none';
    });

    // Pie chart setup
    const ctx = document.getElementById('myPieChart').getContext('2d');
    const myPieChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Menunggu', 'Disahkan', 'Ditolak'],
            datasets: [{
                data: [425, 700, 75],
                backgroundColor: ['#B74A4C', '#8A2565', '#7B577D'],
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false,
                }
            }
        }
    });

    // Function to get the current day in Malay and time
    function updateDayTime() {
        const daysMalay = ["Ahad", "Isnin", "Selasa", "Rabu", "Khamis", "Jumaat", "Sabtu"]; // Malay days
        const now = new Date();

        const day = daysMalay[now.getDay()]; // Get the current day (0-6)
        const hours = now.getHours().toString().padStart(2, '0'); // Hours (24-hour format)
        const minutes = now.getMinutes().toString().padStart(2, '0'); // Minutes
        const ampm = hours >= 12 ? 'pm' : 'am'; // AM or PM

        const formattedTime = `${hours}:${minutes}${ampm}`;
        const formattedDayTime = `${day} ${formattedTime}`;

        console.log(formattedDayTime); // Check if the formatted time is correct in the console

        // Check if the element exists
        const currentDayTimeElement = document.getElementById("currentDayTime");
        if (currentDayTimeElement) {
            currentDayTimeElement.innerText = formattedDayTime;
        } else {
            console.error("Element with id 'currentDayTime' not found!");
        }
    }

    // Call the updateDayTime function
    updateDayTime();
});
