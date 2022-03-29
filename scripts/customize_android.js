/**
 * This script adds the values from colors.json to a colors.xml resource for android
 *
 * Note: This script was written to work with ES5
 */
const fs = require('fs');
try {
  if (fs.existsSync('../../customization.android.json')) {
    fs.readFile('../../customization.android.json', 'utf8', function (err, data) {
      let customization = JSON.parse(data)
      console.log(customization)
      const colors = {}
      Object.keys(customization)
        .filter((item) => item !== 'onfidoButtonCornerRadius' && customization[item])
        .forEach(colorKey => colors[colorKey] = customization[colorKey])

      // Explictly check and create needed directories to support older js versions
      if (!fs.existsSync('android')) {
        fs.mkdirSync('android')
      }
      if (!fs.existsSync('android/src')) {
        fs.mkdirSync('android/src')
      }
      if (!fs.existsSync('android/src/main')) {
        fs.mkdirSync('android/src/main')
      }
      if (!fs.existsSync('android/src/main/res')) {
        fs.mkdirSync('android/src/main/res')
      }
      if (!fs.existsSync('android/src/main/res/values')) {
        fs.mkdirSync('android/src/main/res/values')
      }

      fs.writeFile('android/src/main/res/values/colors.xml', generateColorsFileContent(colors), function (e) {
        if (e != null) {
          console.log('\nAn error occured while trying to update colors:\n' + e + '\n')
        } else {
          console.log("\nColors were successfully updated\n")
        }
      })

      if (customization.onfidoButtonCornerRadius) {
        fs.writeFile('android/src/main/res/values/dimens.xml', generateDimensFileContent(customization.onfidoButtonCornerRadius), function (e) {
          if (e != null) {
            console.log('\nAn error occured while trying to update border radius:\n' + e + '\n')
          } else {
            console.log("\Border radius was successfully updated\n")
          }
        })
      }
    });
  } else {
    console.log('\nNo colors.json was found. Ensure it is at the same level as your node-modules directory\n')
  }
} catch (e) {
  console.log(e)
}

function generateColorsFileContent(colors) {
  let fileContent = '<?xml version="1.0" encoding="utf-8"?>\n'
  fileContent += '<resources>\n'
  Object.keys(colors).forEach((color) => {
    fileContent += '\t<color name=\"'
    fileContent += color
    fileContent += "\">"
    fileContent += colors[color]
    fileContent += "</color>\n"
  })
  fileContent += "</resources>"
  return fileContent
}

function generateDimensFileContent(borderRadius) {
  let fileContent = '<resources>\n'
  fileContent += '\t<dimen name=\"'
  fileContent += 'onfidoButtonCornerRadius'
  fileContent += "\">"
  fileContent += borderRadius
  fileContent += "dp"
  fileContent += "</dimen>\n"
  fileContent += "</resources>"
  return fileContent
}
