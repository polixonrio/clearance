/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [

    "./views/*.ejs ",
    "./views/login.ejs",
    "./views/formgenerate.ejs",
    "./views/students.ejs",
    "./views/filter.ejs",
    

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

