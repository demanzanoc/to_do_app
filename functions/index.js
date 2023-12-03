const functions = require("firebase-functions");
const admin = require("firebase-admin");
const {Translate} = require("@google-cloud/translate").v2;

admin.initializeApp();

const translate = new Translate();

exports.translateTask = functions.firestore
    .document("users/{userId}/to_dos/{taskId}")
    .onCreate(async (snapshot, context) => {
      const taskData = snapshot.data();

      if (taskData.title && taskData.description) {
        const textToTranslate = `${taskData.title}. ${taskData.description}`;

        try {
          const [translation] =
            await translate.translate(textToTranslate, "en");

          return snapshot.ref.update({
            translatedText: translation,
          });
        } catch (error) {
          console.error("Error during translation:", error);
          return null;
        }
      } else {
        console.error("title or description missing in taskData");
        return null;
      }
    });
