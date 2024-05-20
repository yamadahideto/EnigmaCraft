module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  plugins: [require("daisyui")],
  theme: {
    extend: {
      // colors: {
      //   bodyColor: "#F2EDDA",
      //   footer: "#672516",
      //   mainContentColor: "#FFF6EA",
      //   mainTextColor: "#A23D13",
      // },
      colors: {
        header: "#060608",
        bodyColor: "#020100",
        footer: "#11215a",
        mainContentColor: "#020100",
        mainTextColor: "#A23D13",
      },
      fontFamily: {
        "zen-old-mincho": ['"Zen Old Mincho"', "serif", "bold"],
      },
      keyframes: {
        flashFade: {
          "0%": { transform: "translateX(180px)", opacity: 0 },
          "20%": { transform: "translateX(0)", opacity: 1 },
          "80%": { transform: "translateX(0)", opacity: 1 },
          "100%": { transform: "translateX(180px)", opacity: 0 },
        },
      },
      animation: {
        flashFade: "flashFade 5.0s forwards",
      },
    },
  },
};
