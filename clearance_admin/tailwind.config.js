/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [

    "./views/*.ejs ",
    "./views/adminlogin.ejs",
    "./views/excelupload.ejs",
    

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

