# pdfmerge

DOS program combines multiple PDFs into one by using zip merge.

## Usage

```
pdfmerge.exe <odd.pdf>[,...] [<even.pdf>[,...]]
```

### Straight Merge

The simpliest way to `pdfmerge.exe` is to give it a list of PDFs separated by commas:

```
pdfmerge mercury.pdf,venus.pdf,earth.pdf
```

The resulting file `temp-<timestamp>.pdf` will combine all planets sequentially into one PDF file.

### Odd & Even

```
pdfmerge odd.pdf even.pdf
```

If you have two or more PDFs and each contain only odd or even pages, you can use the second argument to zip merge them.
The above command combines `odd.pdf` and `even.pdf` to produce a new combined file with interweaving odd & even pages.
See `test` folder for these tw files (run `make test`):

| Page | `odd.pdf` | `even.pdf` |
|:---:| --- | --- |
| 1 | Sun | Mercury |
| 2 | Venus | Earth |
| 3 | Mars | Jupiter |
| 4 | Saturn | Uranus |
| 5 | Neptune | Pluto |

The output will be in this order:

| Page | `temp-12341243.pdf` |
|:---:| --- |
| 1 | Sun |
| 2 | Mercury |
| 3 | Venus |
| 4 | Earth |
| 5 | Mars |
| 6 | Jupiter |
| 7 | Saturn |
| 8 | Unranus |
| 9 | Neptune |
| 10 | Pluto |

### Multiple Odds and Evens

```
pdfmerge sun-earth.pdf,mars.pdf jupiter-neptune.pdf,pluto.pdf
```

| Original Page | `temp-12341243.pdf` |
|---:| --- |
| 1 | Sun |
| 6 | Jupiter |
| 2 | Mercury |
| 7 | Saturn |
| 3 | Venus |
| 8 | Unranus |
| 4 | Earth |
| 9 | Neptune |
| 5 | Mars |
| 10 | Pluto |
