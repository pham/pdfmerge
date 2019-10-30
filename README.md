# pdfmerge

DOS program combines multiple PDFs into one by using zip merge.

## Usage

### Odd & Even

```
pdfmerge odd.pdf even.pdf
```

Combines `odd.pdf` and `even.pdf` to produce a new combined
file `temp-<unixtimestamp>.pdf`.

The resulting file will interweave the odd and even pages from both files.

| `odd.pdf` | `even.pdf` |
| --- | --- |
| Sun | Mercury |
| Venus | Earth |
| Mars | Asteroids Belt |
| Jupiter | Saturn |
| Uranus | Neptune |
| Pluto | Kuiper Belt |

The output will be in this order:

| `temp-12341243.pdf` |
| --- |
| Sun |
| Mercury |
| Venus |
| Earth |
| Mars |
| Asteroids Belt |
| Jupiter |
| Saturn |
| Unranus |
| Neptue |
| Pluto |
| Kuiper Belt |

### Multiple Odds and Even

```
pdfmerge odd-1.pdf,odd-2.pdf even-1.pdf,even-2.pdf,even-3.pdf
```

### Simple Merge

```
pdfmerge page-1.pdf,page-2-9.pdf,page-10-101.pdf
```
