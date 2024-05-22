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
      colors: {
        header: "#0f1f52",
        bodyColor: "#020100",
        footer: "#0f1f52",
        mainContentColor: "#020100",
        mainTextColor: "#3185d9",
        buttonColor: "#3185d9",
        correctText: "#f2c13b",
        test: "#001b64",
        editDeleteBtn: "#f2c13b",
        buttonText: "#c96a30",
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
