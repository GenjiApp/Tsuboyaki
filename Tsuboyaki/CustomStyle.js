var styleElement = document.createElement('style');
styleElement.textContent = 'div[data-testid="sidebarColumn"] { display: none !important; }';
styleElement.textContent += 'div[data-testid="primaryColumn"] { max-width: 100% !important; }';
styleElement.textContent += 'main > div:first-child > div { max-width: 100% !important; }';
styleElement.textContent += 'div[data-testid="primaryColumn"] > div > div { max-width: 100% !important; }';
document.documentElement.appendChild(styleElement);
