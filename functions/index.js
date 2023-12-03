const functions = require("firebase-functions");
const admin = require("firebase-admin");
const {Translate} = require("@google-cloud/translate").v2;

admin.initializeApp();

const translate = new Translate();
const language = "en";

exports.translateTask = functions.firestore
    .document("users/{userId}/to_dos/{taskId}")
    .onCreate(async (snapshot, context) => {
      const taskData = snapshot.data();

      if (taskData.title && taskData.description) {
        const title = `${taskData.title}`;
        const description = `${taskData.description}`;
        try {
          const [titleTranslated] =
            await translate.translate(title, language);
          const [descriptionTranslated] =
            await translate.translate(description, language);
          const translationData = {
            translatedTitle: titleTranslated,
            translatedDescription: descriptionTranslated,
            lang: language,
          };
          return snapshot.ref.update({translation: translationData});
        } catch (error) {
          console.error("Error during translation:", error);
          return null;
        }
      } else {
        console.error("title or description missing in taskData");
        return null;
      }
    });
