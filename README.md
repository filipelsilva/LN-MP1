# Run tests

`target=<name of file without extension> make test`

Example: `target=mix2numerical make test`

# Progress

- [x] mmm2mm

- [x] mix2numerical

* mmm2mm + mix2numerical-part

- [x] pt2en

* pt2en-part + mix2numerical-part

- [x] en2pt

* invert pt2en

- [x] day

- [x] month

- [x] year

- [x] datenum2text

* month + removeslash + day + removeslash + datenum2text-part + year

- [x] mix2text

* union of:
    * compose of:
        * compose of:
            * mix2numerical
            * datenum2text
        * pt2en
    * compose of:
        * mix2numerical
        * datenum2text

- [x] date2text

* union of:
    * mix2text
    * compose of:
        * invert mix2numerical
        * mix2text
