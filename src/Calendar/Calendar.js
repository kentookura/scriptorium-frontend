"use strict";

const ical = require("ical");
const data = ical.parseICS(
  fs.readFile("CGA_WS2022.ics", "utf8", (data) => {
    console.log(data);
  })
);

export const calendar = function () {
  return data;
};

export const square = function (n) {
  return n * n;
};
