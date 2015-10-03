require 'date'
require 'alexa_rubykit'

class AuthorIntent

  attr_reader :response

  BIBLE = {
    "genesis" => {
      "testament" => "old",
      "purpose" => "describes the creation; gives the history of the old world, and of the steps taken by god toward the formation of theocracy.",
      "author" => "moses"
    },
    "exodus" => {
      "testament" => "old",
      "purpose" => "the history of israel's departure from egypt; the giving of the law; the tabernacle.",
      "author" => "moses"
    },
    "leviticus" => {
      "testament" => "old",
      "purpose" => "the ceremonial law.",
      "author" => "moses"
    },
    "numbers" => {
      "testament" => "old",
      "purpose" => "the census of the people; the story of the wanderings in the wilderness.",
      "author" => "moses"
    },
    "deuteronomy" => {
      "testament" => "old",
      "purpose" => "the law rehearsed; the death of moses.",
      "author" => "moses"
    },
    "joshua" => {
      "testament" => "old",
      "purpose" => "the story of the conquest and partition of canaan.",
      "author" => "joshua"
    },
    "judges" => {
      "testament" => "old",
      "purpose" => "the history of the nation from joshua to samson.",
      "author" => "samuel, nathan and gad"
    },
    "ruth" => {
      "testament" => "old",
      "purpose" => "the story of the ancestors of the royal family of judah.",
      "author" => "samuel, nathan and gad"
    },
    "1 samuel" => {
      "testament" => "old",
      "purpose" => "the story of the nation during the judgeship of samuel and the reign of saul.",
      "author" => "samuel, nathan and gad"
    },
    "2 samuel" => {
      "testament" => "old",
      "purpose" => "story of the reign of david.",
      "author" => "samuel, nathan and gad"
    },
    "1 kings" => {
      "testament" => "old",
      "purpose" => "the books of kings form only one book in the hebrew mss. they contain the history of the nation from david's death and solomon's accession to the destruction of the kingdom of judah and the desolation of jerusalem, with a supplemental notice of the liberation of jehoiachin from his prison at babylon, twenty-six years later; they comprehend the whole time of the israelitish monarchy, exclusive of the reigns of saul and david.",
      "author" => "jeremiah"
    },
    "2 kings" => {
      "testament" => "old",
      "purpose" => "the books of kings form only one book in the hebrew mss. they contain the history of the nation from david's death and solomon's accession to the destruction of the kingdom of judah and the desolation of jerusalem, with a supplemental notice of the liberation of jehoiachin from his prison at babylon, twenty-six years later; they comprehend the whole time of the israelitish monarchy, exclusive of the reigns of saul and david.",
      "author" => "jeremiah"
    },
    "1 chronicles" => {
      "testament" => "old",
      "purpose" => "are so called as being the record made by the appointed historiographers of the kingdoms of judah and israel; they are the official histories of those kingdoms.",
      "author" => "ezra"
    },
    "2 chronicles" => {
      "testament" => "old",
      "purpose" => "are so called as being the record made by the appointed historiographers of the kingdoms of judah and israel; they are the official histories of those kingdoms.",
      "author" => "ezra"
    },
    "ezra" => {
      "testament" => "old",
      "purpose" => "the story of the return of the jews from the babylonish captivity, and of the rebuilding of the temple.",
      "author" => "ezra"
    },
    "nehemiah" => {
      "testament" => "old",
      "purpose" => "a further account of the rebuilding of the temple and city, and of the obstacles encountered and overcome.",
      "author" => "ezra"
    },
    "esther" => {
      "testament" => "old",
      "purpose" => "the story of a jewess who becomes queen of persia and saves the jewish people from destruction.",
      "author" => "mordecai"
    },
    "job" => {
      "testament" => "old",
      "purpose" => "the story of the trials and patience of a holy man of edom.",
      "author" => "the book of job does not specifically name its author. the most likely candidates are job, elihu, moses and solomon."
    },
    "psalms" => {
      "testament" => "old",
      "purpose" => "a collection of sacred poems intended for use in the worship of jehovah. chiefly the productions of david.",
      "author" => "several different authors, approximately half by david around 1000 b.c. the earliest psalm is from moses around 1400 b.c. and the latest around 400 b.c."
    },
    "proverbs" => {
      "testament" => "old",
      "purpose" => "the wise sayings of solomon.",
      "author" => "solomon"
    },
    "ecclesiastes" => {
      "testament" => "old",
      "purpose" => "a poem respecting the vanity of earthly things.",
      "author" => "solomon"
    },
    "song of solomon" => {
      "testament" => "old",
      "purpose" => "an allegory relating to the church.",
      "author" => "solomon"
    },
    "isaiah" => {
      "testament" => "old",
      "purpose" => "prophecies respecting christ and his kingdom.",
      "author" => "isaiah"
    },
    "jeremiah" => {
      "testament" => "old",
      "purpose" => "prophecies announcing the captivity of judah, its sufferings, and the final overthrow of its enemies.",
      "author" => "jeremiah"
    },
    "lamentations" => {
      "testament" => "old",
      "purpose" => "the utterance of jeremiah's sorrow upon the capture of jerusalem and the destruction of the temple.",
      "author" => "jeremiah"
    },
    "ezekiel" => {
      "testament" => "old",
      "purpose" => "messages of warning and comfort to the jews in their captivity.",
      "author" => "ezekiel"
    },
    "daniel" => {
      "testament" => "old",
      "purpose" => "a narrative of some of the occurrences of the captivity, and a series of prophecies concerning christ.",
      "author" => "daniel - 550 b.c."
    },
    "hosea" => {
      "testament" => "old",
      "purpose" => "prophecies relating to christ and the latter days.",
      "author" => "hosea"
    },
    "joel" => {
      "testament" => "old",
      "purpose" => "prediction of woes upon judah, and of the favor with which god will receive the penitent people.",
      "author" => "joel"
    },
    "amos" => {
      "testament" => "old",
      "purpose" => "prediction that israel and other neighboring nations will be punished by conquerors from the north, and of the fulfillment of the messiah's kingdom",
      "author" => "amos"
    },
    "obadiah" => {
      "testament" => "old",
      "purpose" => "prediction of the desolation of edom.",
      "author" => "obadiah"
    },
    "jonah" => {
      "testament" => "old",
      "purpose" => "prophecies relating to nineveh.",
      "author" => "jonah"
    },
    "micah" => {
      "testament" => "old",
      "purpose" => "predictions relating to the invasions of shalmaneser and sennacherib, the babylonish captivity, the establishment of a theocratic kingdom in jerusalem, and the birth of the messiah in bethlehem.",
      "author" => "micah"
    },
    "nahum" => {
      "testament" => "old",
      "purpose" => "prediction of the downfall of assyria.",
      "author" => "nahum"
    },
    "habakkuk" => {
      "testament" => "old",
      "purpose" => "a prediction of the doom of the chaldeans.",
      "author" => "habakkuk"
    },
    "zephaniah" => {
      "testament" => "old",
      "purpose" => "prophecies relating to the rebuilding of the temple and the messiah.",
      "author" => "zephaniah"
    },
    "haggai" => {
      "testament" => "old",
      "purpose" => "prophecies concerning the rebuilding of the temple.",
      "author" => "haggai"
    },
    "zechariah" => {
      "testament" => "old",
      "purpose" => "prophecies relating to the rebuilding of the temple and the messiah.",
      "author" => "zechariah"
    },
    "malachi" => {
      "testament" => "old",
      "purpose" => "prophecies relating to the calling of the gentiles and the coming of christ.",
      "author" => "malachi"
    },
    "matthew" => {
      "testament" => "new",
      "purpose" => "a brief history of the life of christ.",
      "author" => "matthew"
    },
    "mark" => {
      "testament" => "new",
      "purpose" => "a brief history of the life of christ, supplying some incidents omitted by st. matthew.",
      "author" => "john mark"
    },
    "luke" => {
      "testament" => "new",
      "purpose" => "the history of the life of christ, with especial reference to his most important acts and discourses.",
      "author" => "luke"
    },
    "john" => {
      "testament" => "new",
      "purpose" => "the life of christ, giving important discourses not related by the other evangelists.",
      "author" => "john"
    },
    "acts" => {
      "testament" => "new",
      "purpose" => "the history of the labors of the apostles and of the foundation of the christian church.",
      "author" => "luke"
    },
    "romans" => {
      "testament" => "new",
      "purpose" => "a treatise by st. paul on the doctrine of justification by christ.",
      "author" => "paul"
    },
    "1 corinthians" => {
      "testament" => "new",
      "purpose" => "a letter from st. paul to the corinthians, correcting errors into which they had fallen.",
      "author" => "paul"
    },
    "2 corinthians" => {
      "testament" => "new",
      "purpose" => "st. paul confirms his disciples in their faith, and vindicates his own character.",
      "author" => "paul"
    },
    "galatians" => {
      "testament" => "new",
      "purpose" => "st. paul maintains that we are justified by faith, and not by rites.",
      "author" => "paul"
    },
    "ephesians" => {
      "testament" => "new",
      "purpose" => "a treatise by st. paul on the power of divine grace.",
      "author" => "paul"
    },
    "philippians" => {
      "testament" => "new",
      "purpose" => "st. paul sets forth the beauty of christian kindness.",
      "author" => "paul"
    },
    "colossians" => {
      "testament" => "new",
      "purpose" => "st. paul warns his disciples against errors, and exhorts to certain duties.",
      "author" => "paul"
    },
    "1 thessalonians" => {
      "testament" => "new",
      "purpose" => "st. paul exhorts his disciples to continue in the faith and in holy conversation.",
      "author" => "paul"
    },
    "2 thessalonians" => {
      "testament" => "new",
      "purpose" => "st. paul corrects an error concerning the speedy coming of christ the second time.",
      "author" => "paul"
    },
    "1 timothy" => {
      "testament" => "new",
      "purpose" => "st. paul instructs timothy in the duty of a pastor, and encourages him in the work of the ministry.",
      "author" => "paul"
    },
    "2 timothy" => {
      "testament" => "new",
      "purpose" => "st. paul instructs timothy in the duty of a pastor, and encourages him in the work of the ministry.",
      "author" => "paul"
    },
    "titus" => {
      "testament" => "new",
      "purpose" => "epistle to titus. st. paul encourages titus in the performance of his ministerial duties.",
      "author" => "paul"
    },
    "philemon" => {
      "testament" => "new",
      "purpose" => "an appeal to a converted master to receive a converted escaped slave with kindness.",
      "author" => "paul"
    },
    "hebrews" => {
      "testament" => "new",
      "purpose" => "st. paul maintains that christ is the substance of the ceremonial law.",
      "author" => "author unknown"
    },
    "james" => {
      "testament" => "new",
      "purpose" => "a treatise on the efficacy of faith united with good works.",
      "author" => "james"
    },
    "1 peter" => {
      "testament" => "new",
      "purpose" => "exhortations to a christian life, with various warnings and predictions.",
      "author" => "peter"
    },
    "2 peter" => {
      "testament" => "new",
      "purpose" => "exhortations to a christian life, with various warnings and predictions.",
      "author" => "peter"
    },
    "1 john" => {
      "testament" => "new",
      "purpose" => "respecting the person of our lord, and an exhortation to christian love and conduct.",
      "author" => "john"
    },
    "2 john" => {
      "testament" => "new",
      "purpose" => "st. john warns a converted lady against false teachers.",
      "author" => "john"
    },
    "3 john" => {
      "testament" => "new",
      "purpose" => "a letter to gaius, praising him for his hospitality.",
      "author" => "john"
    },
    "jude" => {
      "testament" => "new",
      "purpose" => "warnings against deceivers",
      "author" => "jude"
    },
    "revelation" => {
      "testament" => "new",
      "purpose" => "the future of the church foretold.",
      "author" => "john"
    }
  }

  def initialize
    @response = AlexaRubykit::Response.new
  end

  def call(request)
    @book = request.slots['book']['value'].downcase
    puts "=====book"
    puts @book
    @response.add_speech("The book of %s was written by %s" % [@book, BIBLE[@book]['author']])
    @response
  end

end
