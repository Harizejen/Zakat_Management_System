document.addEventListener('DOMContentLoaded', () => {
    // Select the toggle button using its class
    const toggleBtn = document.querySelector('.toggle-btn');
    const overlay = document.getElementById('overlay'); // Select the overlay

    // Check if the toggle button exists before proceeding
    if (toggleBtn) {
        // Select the sidebar and content elements
        const sidebar = document.getElementById('sidebar');
        const content = document.getElementById('content');

        // Add the click event listener to toggle the sidebar and content visibility
        toggleBtn.addEventListener('click', () => {
            sidebar.classList.toggle('active');
            content.classList.toggle('active');
            overlay.classList.toggle('active'); // Toggle the overlay
        });

        // Add click event listener to the overlay to close the sidebar
        overlay.addEventListener('click', () => {
            sidebar.classList.remove('active');
            content.classList.remove('active');
            overlay.classList.remove('active'); // Hide the overlay
        });
    }
});