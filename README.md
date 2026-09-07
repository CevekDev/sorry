# sorry

A single-page apology letter, hosted on GitHub Pages.

**Live:** https://cevekdev.github.io/sorry/

## Files

| File | What it is |
| --- | --- |
| `sorry.html` | The source. **Edit this one.** It has no `<head>` because it is also published as a Claude Artifact, which supplies one. |
| `index.html` | What GitHub Pages serves. **Generated — do not edit by hand.** |
| `build.ps1` | Wraps `sorry.html` into a complete standalone `index.html` (doctype, charset, viewport, `noindex`). |

The `viewport` meta tag matters: without it the page renders 980px wide and zoomed out on a phone.

## Updating the page

```powershell
.\build.ps1
git commit -am "update the letter"
git push
```

GitHub Pages redeploys within a minute or so.

## Running it locally

```powershell
python -m http.server 8080
```

Then open http://localhost:8080/ — or, from a phone on the same Wi-Fi, `http://<your-lan-ip>:8080/`.
