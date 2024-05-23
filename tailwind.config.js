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
        "text-focus-in": {
          "0%": {
            filter: "blur(12px)",
            opacity: "0",
          },
          to: {
            filter: "blur(0)",
            opacity: "1",
          },
        },
        "tracking-in-expand-fwd-bottom": {
          "0%": {
            "letter-spacing": "-.5em",
            transform: "translateZ(-700px) translateY(500px)",
            opacity: "0",
          },
          "40%": {
            opacity: ".6",
          },
          to: {
            transform: "translateZ(0) translateY(0)",
            opacity: "1",
          },
        },
        "text-pop-up-top": {
          "0%": {
            transform: "translateY(0)",
            "transform-origin": "50% 50%",
            "text-shadow": "none",
          },
          to: {
            transform: "translateY(-50px)",
            "transform-origin": "50% 50%",
            "text-shadow":
              "0 1px 0 #ccc, 0 2px 0 #ccc, 0 3px 0 #ccc, 0 4px 0 #ccc, 0 5px 0 #ccc, 0 6px 0 #ccc, 0 7px 0 #ccc, 0 8px 0 #ccc, 0 9px 0 #ccc, 0 50px 30px rgba(0, 0, 0, .3)",
          },
        },
      },
      animation: {
        flashFade: "flashFade 5.0s forwards",
        "text-focus-in": "text-focus-in 1s linear",
        "tracking-in-expand-fwd-bottom":
          "tracking-in-expand-fwd-bottom 1s cubic-bezier(0.215, 0.610, 0.355, 1.000)   both",
        "text-pop-up-top": "text-pop-up-top 0.8s linear  0.2 both",
      },
    },
  },
};
