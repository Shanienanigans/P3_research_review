// =======================================================
// 1. EXISTING FEATURE: Submit form on ENTER
// =======================================================
document.addEventListener('DOMContentLoaded', () => {
    const fields = document.getElementsByClassName('submittable');

    for (let field of fields) {
        field.addEventListener('keydown', function (e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                this.form.submit();
            }
        });
    }
});


// =======================================================
// 2. NEW FEATURE: Live Search Auto-Suggest
// =======================================================

// Only attach live search if the search bar exists on the page
document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.getElementById("globalSearch");
    if (!searchInput) return; // No search bar → stop

    // Create dropdown container
    const dropdown = document.createElement("div");
    dropdown.id = "search-suggestions";
    dropdown.style.position = "absolute";
    dropdown.style.background = "white";
    dropdown.style.border = "1px solid #ddd";
    dropdown.style.width = searchInput.offsetWidth + "px";
    dropdown.style.maxHeight = "250px";
    dropdown.style.overflowY = "auto";
    dropdown.style.borderRadius = "8px";
    dropdown.style.boxShadow = "0 4px 12px rgba(0,0,0,0.08)";
    dropdown.style.display = "none"; // hidden by default
    dropdown.style.zIndex = "1000";

    searchInput.parentNode.appendChild(dropdown);

    let timer = null;

    searchInput.addEventListener("input", function () {
        const query = this.value.trim();

        if (timer) clearTimeout(timer);

        // Delay requests for smoother UI
        timer = setTimeout(() => {
            if (query.length < 2) {
                dropdown.style.display = "none";
                return;
            }

            fetch(`/api/search?q=${encodeURIComponent(query)}`)
                .then(res => res.json())
                .then(results => {
                    dropdown.innerHTML = "";

                    if (results.length === 0) {
                        dropdown.style.display = "none";
                        return;
                    }

                    results.forEach(paper => {
                        const item = document.createElement("div");
                        item.style.padding = "12px";
                        item.style.cursor = "pointer";
                        item.style.borderBottom = "1px solid #f2f2f2";

                        item.innerHTML = `
                            <strong>${paper.title}</strong><br>
                            <span style="color: gray; font-size: 13px">${paper.authors}</span>
                        `;

                        item.addEventListener("click", () => {
                            window.location.href = `/paper/${paper.paperId}`;
                        });

                        dropdown.appendChild(item);
                    });

                    dropdown.style.display = "block";
                });

        }, 300); // wait 300ms before sending request
    });

    // Hide dropdown when user clicks elsewhere
    document.addEventListener("click", (e) => {
        if (!searchInput.contains(e.target) && !dropdown.contains(e.target)) {
            dropdown.style.display = "none";
        }
    });
});
