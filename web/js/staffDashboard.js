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
});
