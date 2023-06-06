/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [

    "./views/*.ejs ",
    "./views/2studentupdate.ejs",
    "./views/formgenerate.ejs",
    "./views/studentlogin.ejs",
    

  ],

  theme: {
    extend: {
      fontFamily: {
        'poppins': ['Poppins', 'sans-serif']
      },
    },
  },
  plugins: [
    
    require('flowbite/plugin')

  ],
}

