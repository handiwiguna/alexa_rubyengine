require 'date'
require 'alexa_rubykit'

class AuthorIntent

  attr_reader :response

  BIBLE = {
    "Genesis": {
        "testament": "OLD",
        "purpose": "Describes the creation; gives the history of the old world, and of the steps taken by God toward the formation of theocracy.",
        "author": "Moses"
    },
    "Exodus": {
        "testament": "OLD",
        "purpose": "The history of Israel's departure from Egypt; the giving of the law; the tabernacle.",
        "author": "Moses"
    },
    "Leviticus": {
        "testament": "OLD",
        "purpose": "The ceremonial law.",
        "author": "Moses"
    },
    "Numbers": {
        "testament": "OLD",
        "purpose": "The census of the people; the story of the wanderings in the wilderness.",
        "author": "Moses"
    },
    "Deuteronomy": {
        "testament": "OLD",
        "purpose": "The law rehearsed; the death of Moses.",
        "author": "Moses"
    },
    "Joshua": {
        "testament": "OLD",
        "purpose": "The story of the conquest and partition of Canaan.",
        "author": "Joshua"
    },
    "Judges": {
        "testament": "OLD",
        "purpose": "The history of the nation from Joshua to Samson.",
        "author": "Samuel, Nathan and Gad"
    },
    "Ruth": {
        "testament": "OLD",
        "purpose": "The story of the ancestors of the royal family of Judah.",
        "author": "Samuel, Nathan and Gad"
    },
    "1 Samuel": {
        "testament": "OLD",
        "purpose": "The story of the nation during the judgeship of Samuel and the reign of Saul.",
        "author": "Samuel, Nathan and Gad"
    },
    "2 Samuel": {
        "testament": "OLD",
        "purpose": "Story of the reign of David.",
        "author": "Samuel, Nathan and Gad"
    },
    "1 Kings": {
        "testament": "OLD",
        "purpose": "The books of Kings form only one book in the Hebrew MSS. They contain the history of the nation from David's death and Solomon's accession to the destruction of the kingdom of Judah and the desolation of Jerusalem, with a supplemental notice of the liberation of Jehoiachin from his prison at Babylon, twenty-six years later; they comprehend the whole time of the Israelitish monarchy, exclusive of the reigns of Saul and David.",
        "author": "Jeremiah"
    },
    "2 Kings": {
        "testament": "OLD",
        "purpose": "The books of Kings form only one book in the Hebrew MSS. They contain the history of the nation from David's death and Solomon's accession to the destruction of the kingdom of Judah and the desolation of Jerusalem, with a supplemental notice of the liberation of Jehoiachin from his prison at Babylon, twenty-six years later; they comprehend the whole time of the Israelitish monarchy, exclusive of the reigns of Saul and David.",
        "author": "Jeremiah"
    },
    "1 Chronicles": {
        "testament": "OLD",
        "purpose": "are so called as being the record made by the appointed historiographers of the kingdoms of Judah and Israel; they are the official histories of those kingdoms.",
        "author": "Ezra"
    },
    "2 Chronicles": {
        "testament": "OLD",
        "purpose": "are so called as being the record made by the appointed historiographers of the kingdoms of Judah and Israel; they are the official histories of those kingdoms.",
        "author": "Ezra"
    },
    "Ezra": {
        "testament": "OLD",
        "purpose": "The story of the return of the Jews from the Babylonish captivity, and of the rebuilding of the temple.",
        "author": "Ezra"
    },
    "Nehemiah": {
        "testament": "OLD",
        "purpose": "A further account of the rebuilding of the temple and city, and of the obstacles encountered and overcome.",
        "author": "Ezra"
    },
    "Esther": {
        "testament": "OLD",
        "purpose": "The story of a Jewess who becomes queen of Persia and saves the Jewish people from destruction.",
        "author": "Mordecai"
    },
    "Job": {
        "testament": "OLD",
        "purpose": "The story of the trials and patience of a holy man of Edom.",
        "author": "The Book of Job does not specifically name its author. The most likely candidates are Job, Elihu, Moses and Solomon."
    },
    "Psalms": {
        "testament": "OLD",
        "purpose": "A collection of sacred poems intended for use in the worship of Jehovah. Chiefly the productions of David.",
        "author": "several different authors, approximately half by David around 1000 B.C. the earliest psalm is from Moses around 1400 B.C. and the latest around 400 B.C."
    },
    "Proverbs": {
        "testament": "OLD",
        "purpose": "The wise sayings of Solomon.",
        "author": "Solomon"
    },
    "Ecclesiastes": {
        "testament": "OLD",
        "purpose": "A poem respecting the vanity of earthly things.",
        "author": "Solomon"
    },
    "Song of Solomon": {
        "testament": "OLD",
        "purpose": "An allegory relating to the church.",
        "author": "Solomon"
    },
    "Isaiah": {
        "testament": "OLD",
        "purpose": "Prophecies respecting Christ and his kingdom.",
        "author": "Isaiah"
    },
    "Jeremiah": {
        "testament": "OLD",
        "purpose": "Prophecies announcing the captivity of Judah, its sufferings, and the final overthrow of its enemies.",
        "author": "Jeremiah"
    },
    "Lamentations": {
        "testament": "OLD",
        "purpose": "The utterance of Jeremiah's sorrow upon the capture of Jerusalem and the destruction of the temple.",
        "author": "Jeremiah"
    },
    "Ezekiel": {
        "testament": "OLD",
        "purpose": "Messages of warning and comfort to the Jews in their captivity.",
        "author": "Ezekiel"
    },
    "Daniel": {
        "testament": "OLD",
        "purpose": "A narrative of some of the occurrences of the captivity, and a series of prophecies concerning Christ.",
        "author": "Daniel - 550 B.C."
    },
    "Hosea": {
        "testament": "OLD",
        "purpose": "Prophecies relating to Christ and the latter days.",
        "author": "Hosea"
    },
    "Joel": {
        "testament": "OLD",
        "purpose": "Prediction of woes upon Judah, and of the favor with which God will receive the penitent people.",
        "author": "Joel"
    },
    "Amos": {
        "testament": "OLD",
        "purpose": "Prediction that Israel and other neighboring nations will be punished by conquerors from the north, and of the fulfillment of the Messiah's kingdom",
        "author": "Amos"
    },
    "Obadiah": {
        "testament": "OLD",
        "purpose": "Prediction of the desolation of Edom.",
        "author": "Obadiah"
    },
    "Jonah": {
        "testament": "OLD",
        "purpose": "Prophecies relating to Nineveh.",
        "author": "Jonah"
    },
    "Micah": {
        "testament": "OLD",
        "purpose": "Predictions relating to the invasions of Shalmaneser and Sennacherib, the Babylonish captivity, the establishment of a theocratic kingdom in Jerusalem, and the birth of the Messiah in Bethlehem.",
        "author": "Micah"
    },
    "Nahum": {
        "testament": "OLD",
        "purpose": "Prediction of the downfall of Assyria.",
        "author": "Nahum"
    },
    "Habakkuk": {
        "testament": "OLD",
        "purpose": "A prediction of the doom of the Chaldeans.",
        "author": "Habakkuk"
    },
    "Zephaniah": {
        "testament": "OLD",
        "purpose": "Prophecies relating to the rebuilding of the temple and the Messiah.",
        "author": "Zephaniah"
    },
    "Haggai": {
        "testament": "OLD",
        "purpose": "Prophecies concerning the rebuilding of the temple.",
        "author": "Haggai"
    },
    "Zechariah": {
        "testament": "OLD",
        "purpose": "Prophecies relating to the rebuilding of the temple and the Messiah.",
        "author": "Zechariah"
    },
    "Malachi": {
        "testament": "OLD",
        "purpose": "Prophecies relating to the calling of the Gentiles and the coming of Christ.",
        "author": "Malachi"
    },
    "Matthew": {
        "testament": "NEW",
        "purpose": "A brief history of the life of Christ.",
        "author": "Matthew"
    },
    "Mark": {
        "testament": "NEW",
        "purpose": "A brief history of the life of Christ, supplying some incidents omitted by St. Matthew.",
        "author": "John Mark"
    },
    "Luke": {
        "testament": "NEW",
        "purpose": "The history of the life of Christ, with especial reference to his most important acts and discourses.",
        "author": "Luke"
    },
    "John": {
        "testament": "NEW",
        "purpose": "The life of Christ, giving important discourses not related by the other evangelists.",
        "author": "John"
    },
    "Acts": {
        "testament": "NEW",
        "purpose": "The history of the labors of the apostles and of the foundation of the Christian Church.",
        "author": "Luke"
    },
    "Romans": {
        "testament": "NEW",
        "purpose": "A treatise by St. Paul on the doctrine of justification by Christ.",
        "author": "Paul"
    },
    "1 Corinthians": {
        "testament": "NEW",
        "purpose": "A letter from St. Paul to the Corinthians, correcting errors into which they had fallen.",
        "author": "Paul"
    },
    "2 Corinthians": {
        "testament": "NEW",
        "purpose": "St. Paul confirms his disciples in their faith, and vindicates his own character.",
        "author": "Paul"
    },
    "Galatians": {
        "testament": "NEW",
        "purpose": "St. Paul maintains that we are justified by faith, and not by rites.",
        "author": "Paul"
    },
    "Ephesians": {
        "testament": "NEW",
        "purpose": "A treatise by St. Paul on the power of divine grace.",
        "author": "Paul"
    },
    "Philippians": {
        "testament": "NEW",
        "purpose": "St. Paul sets forth the beauty of Christian kindness.",
        "author": "Paul"
    },
    "Colossians": {
        "testament": "NEW",
        "purpose": "St. Paul warns his disciples against errors, and exhorts to certain duties.",
        "author": "Paul"
    },
    "1 Thessalonians": {
        "testament": "NEW",
        "purpose": "St. Paul exhorts his disciples to continue in the faith and in holy conversation.",
        "author": "Paul"
    },
    "2 Thessalonians": {
        "testament": "NEW",
        "purpose": "St. Paul corrects an error concerning the speedy coming of Christ the second time.",
        "author": "Paul"
    },
    "1 Timothy": {
        "testament": "NEW",
        "purpose": "St. Paul instructs Timothy in the duty of a pastor, and encourages him in the work of the ministry.",
        "author": "Paul"
    },
    "2 Timothy": {
        "testament": "NEW",
        "purpose": "St. Paul instructs Timothy in the duty of a pastor, and encourages him in the work of the ministry.",
        "author": "Paul"
    },
    "Titus": {
        "testament": "NEW",
        "purpose": "Epistle to Titus. St. Paul encourages Titus in the performance of his ministerial duties.",
        "author": "Paul"
    },
    "Philemon": {
        "testament": "NEW",
        "purpose": "An appeal to a converted master to receive a converted escaped slave with kindness.",
        "author": "Paul"
    },
    "Hebrews": {
        "testament": "NEW",
        "purpose": "St. Paul maintains that Christ is the substance of the ceremonial law.",
        "author": "author unknown"
    },
    "James": {
        "testament": "NEW",
        "purpose": "A treatise on the efficacy of faith united with good works.",
        "author": "James"
    },
    "1 Peter": {
        "testament": "NEW",
        "purpose": "Exhortations to a Christian life, with various warnings and predictions.",
        "author": "Peter"
    },
    "2 Peter": {
        "testament": "NEW",
        "purpose": "Exhortations to a Christian life, with various warnings and predictions.",
        "author": "Peter"
    },
    "1 John": {
        "testament": "NEW",
        "purpose": "Respecting the person of our Lord, and an exhortation to Christian love and conduct.",
        "author": "John"
    },
    "2 John": {
        "testament": "NEW",
        "purpose": "St. John warns a converted lady against false teachers.",
        "author": "John"
    },
    "3 John": {
        "testament": "NEW",
        "purpose": "A letter to Gaius, praising him for his hospitality.",
        "author": "John"
    },
    "Jude": {
        "testament": "NEW",
        "purpose": "Warnings against deceivers",
        "author": "Jude"
    },
    "Revelation": {
        "testament": "NEW",
        "purpose": "The future of the Church foretold.",
        "author": "John"
    }
}

  def initialize
    @response = AlexaRubykit::Response.new
  end

  def call(request)
    @book = request.slots['books']['value']
    @response.add_speech("The book of %s was written by %s" % [@book, BIBLE[@book]['author']])
    @response
  end

end
