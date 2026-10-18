const storeLinks = {
  ios: 'https://apps.apple.com/app/id6821119177',
  android: 'https://play.google.com/store/apps/details?id=com.ayezAhlaq.app',
};

for (const [platform, url] of Object.entries(storeLinks)) {
  if (!url) continue;
  const link = document.getElementById(`${platform}-link`);
  link.href = url;
  link.classList.remove('disabled');
  link.removeAttribute('aria-disabled');
  link.querySelector('small').textContent = 'حمّل من';
}
