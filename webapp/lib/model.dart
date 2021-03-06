// TODO To be replaced with real models. Just dumping dummy data here to keep controller.dart clean
Map<String, Map> projectData = {
  'project-4f729d35': {
    'id': 'project-4f729d35',
    'name': 'COVID IMAQAL',
    'members': ['Team Member 1', 'Team Member 2', 'Team Member 3', 'Team Member 4', 'Team Member 5'],
    'conversationData': covidImaqalConversationData,
    'activePackages': covidImaqalActivePackages,
    'availablePackages': covidImaqalAvailablePackages,
    'projectConfiguration': covidImaqalProjectConfigurationFormData
  },
  'project-38aac3ae': {
    'id': 'project-38aac3ae',
    'name': 'COVID Kenya',
    'members': ['Team Member 1', 'Team Member 3'],
    'conversationData': {
      'needs-urgent-intervention': 0,
    'awaiting-reply': 0,
    'conversations': []
    },
    'activePackages': {},
    'availablePackages': [],
    'projectConfiguration': covidKenyaProjectConfigurationFormData
  }
};

Map<String, String> teamMembers  = {
  'Team Member 1' : 'email1@organization.org',
  'Team Member 2' : 'email2@organization.org',
  'Team Member 3': 'email3@organization.org'
};

Map covidImaqalConversationData = {
    'needs-urgent-intervention': 3,
    'awaiting-reply': 20,
    'conversations': [
      {
        'text': 'Waa inlahelaa daryel cifimad iyo nabad warta nanakashaqeyan bulshada dhaman wanasodhaweyney naa sanad ka nasohayo hadoo allah nakarsiyo',
        'demogs': 'Male, 20, Displaced'
      },
      {
        'text': 'Ok mahad sanidin',
        'demogs': 'Female, 38'
      },
      {
        'text': 'In lahelo dawlad hoose oo xoogan waxna kaqaban karta ilaalinta sharciyada iyo xuquuqaha shaqsiga ah ee bulshada dhexdeeda',
        'demogs': 'Male'
      }
    ]
};

List<String> projectOrganizations  = [];

Map covidImaqalProjectConfigurationFormData = {
  'project-languages': {
    'English': {
      'send': {'label': 'can send', 'value': true},
      'receive': {'label': 'can receive', 'value': true}
    },
    'Somali': {
      'send': {'label': 'can send', 'value': true},
      'receive': {'label': 'can receive', 'value': true}
    }
  },
  'automated-translations': {
    'label': 'Automated translations enabled',
    'value': true
  },
  'user-configuration': {
      'read-conversations': {
        'label': 'can read conversations',
        'value': 'Person 1, Person 2, Person 3, Person 4'
      },
      'perform-translations': {
        'label': 'can perform translations',
        'value': 'Person 1, Person 2, Person 3'
      },
      'send-messages': {
        'label': 'can send messages',
        'value': 'Person 1, Person 2, Person 3'
      },
      'send-custom-messages': {
        'label': 'can send custom messages',
        'value': 'Person 1, Person 2, Person 3'
      },
      'approve-actions': {
        'label': 'can approve actions',
        'value': 'Person 3, Person 4'
      },
      'configure-project': {
        'label': 'can configure the project',
        'value': 'Person 3, Person 4'
      }
  },
  'coda-integration': {
    'dataset-regex': {
      'label': 'Dataset regex',
      'value': 'Example_Project_.*'
    },
    'firebase-token': {
      'label': 'Firebase auth token',
      'value': 'firebase-adminsdk-12345.json'
    }
  },
  'rapidpro-integration': {
    'start-timestamp': {
      'label': 'Start timestamp',
      'value': '2020-11-13T15:11:27.741'
    },
    'workspace-token': {
      'label': 'Workspace token',
      'value': 'cmFuZG9tIHN0cmluZw'
    }
  }
};

Map covidKenyaProjectConfigurationFormData = {
  'project-languages': {
    'English': {
      'send': {'label': 'can send', 'value': false},
      'receive': {'label': 'can receive', 'value': false}
    },
    'Somali': {
      'send': {'label': 'can send', 'value': false},
      'receive': {'label': 'can receive', 'value': false}
    }
  },
  'automated-translations': {
    'label': 'Automated translations enabled',
    'value': false
  },
  'user-configuration': {
      'read-conversations': {
        'label': 'can read conversations',
        'value': ''
      },
      'perform-translations': {
        'label': 'can perform translations',
        'value': ''
      },
      'send-messages': {
        'label': 'can send messages',
        'value': ''
      },
      'send-custom-messages': {
        'label': 'can send custom messages',
        'value': ''
      },
      'approve-actions': {
        'label': 'can approve actions',
        'value': ''
      },
      'configure-project': {
        'label': 'can configure the project',
        'value': ''
      }
  },
  'coda-integration': {
    'dataset-regex': {
      'label': 'Dataset regex',
      'value': ''
    },
    'firebase-token': {
      'label': 'Firebase auth token',
      'value': ''
    }
  },
  'rapidpro-integration': {
    'start-timestamp': {
      'label': 'Start timestamp',
      'value': new DateTime.now().toIso8601String()
    },
    'workspace-token': {
      'label': 'Workspace token',
      'value': ''
    }
  }
};

List<String> additionalProjectConfigurationLanguages = ['Kiswahili', 'Kinyarwanda'];

Map<String, TagType> tags = {
  'rumour - origin': TagType.Normal,
  'rumour - virus description': TagType.Normal,
  'rumour - cure': TagType.Normal,
  'other tag 1': TagType.Normal,
  'other tag 2': TagType.Normal,
  'other tag 3': TagType.Normal
};

List<Map> changeCommunicationsSuggestedReplies = [
  {
    "messages":
      [
        "Greetings to you dear listener! Thanks for the beautiful way you are sharing your thoughts with us",
        "Saalan, quruz badan nage guddoon dhagaystaha sharafta leh, waad ku mahadsantahay sida quruxda badana ee aad noola wadageyso fikradahaada",
      ],
    "reviewed": true,
    "reviewed-by": "nancy@whatworks.co.ke",
    "reviewed-date": "2020-10-10"
  },
  {
    "messages":
      [
        "Thanks, we hear you and appreciate. We think it is really important to tell you what we know from trusted sources",
        "Mahadsanid, waan ku maqalnaa waanan kuu mahadnaqaynaa. Waxaa muhiim ah inaan kula wadaagno waxaa aan ognahay oo ka yimid ilo lagu kalsoon yahay",
      ],
    "reviewed": false,
    "reviewed-by": "",
    "reviewed-date": ""
  }
];

List<Map> escalatesSuggestedReplies = [
  {
    "messages":
      [
        "Do you need information regarding Coronavirus?",
        "Ma u baahantahay macluumaad ku saabsan xanuunka Koroona fayraska?",
      ],
    "reviewed": false,
    "reviewed-by": "",
    "reviewed-date": ""
  },
  {
    "messages":
      [
        "Thanks for your message. Unfortunately we only provide information on coronavirus.a",
        "Waad ku mahadsantahay farriintaada. Nasiib darro kaliye waxaan bixinaa macluumaad ku saabsan Koronafayraska.",
      ],
    "reviewed": false,
    "reviewed-by": "",
    "reviewed-date": ""
  }
];

class Configuration {
  Map<String, TagType> availableTags = {};
  Map<String, TagType> hasAllTags = {};
  Map<String, TagType> containsLastInTurnTags = {};
  Map<String, TagType> hasNoneTags = {};
  List<Map> suggestedReplies = [];
  Map<String, TagType> addsTags = {};
}

enum TagType {
  Normal,
  Important,
}

Map<String, Map> covidImaqalActivePackages = {
  'package-439c41b9': {
    'id': 'package-439c41b9',
    'name': 'Urgent conversations',
    'conversationsLink': '#/conversations',
    'configurationLink': '#/package-configuration?project=project-4f729d35&package=package-439c41b9',
    'chartData': '${covidImaqalConversationData["needs-urgent-intervention"]} awaiting reply',
    'configurationData': new Configuration()
      ..availableTags = tags
      ..hasAllTags = {'escalate': TagType.Important}
      ..suggestedReplies = escalatesSuggestedReplies
      ..addsTags = {'de-escalate': TagType.Normal, 'no-escalate': TagType.Normal}
  },
  'package-1f895432': {
    'id': 'package-1f895432',
    'name': 'Open conversations',
    'conversationsLink': '#/conversations',
    'configurationLink': '#/package-configuration?project=project-4f729d35&package=package-1f895432',
    'chartData': '30 open conversations',
    'configurationData': new Configuration()..availableTags = tags
  },
  'package-0aef7d7e': {
    'id': 'package-0aef7d7e',
    'name': 'Change communications',
    'conversationsLink': '#/conversations',
    'configurationLink': '#/package-configuration?project=project-4f729d35&package=package-0aef7d7e',
    'chartData': '',
    'configurationData': new Configuration()
      ..availableTags = tags
      ..containsLastInTurnTags = {'denial': TagType.Normal , 'rumour': TagType.Normal}
      ..hasNoneTags = {'escalate': TagType.Normal, 'STOP': TagType.Normal}
      ..suggestedReplies = changeCommunicationsSuggestedReplies
      ..addsTags = {'Organic conversation appreciation': TagType.Normal, 'Organic conversation hostility': TagType.Normal,
        'RP Substance appreciation': TagType.Normal, 'RP Substance hostility': TagType.Normal}
    },
};

List<Map> covidImaqalAvailablePackages = [
  {'name': 'Quick Poll', 'description': 'Ask a question with fixed answers', 'details': {'Needs': 'Q/A, Labelling team, Safeguarding response', 'Produces': 'Dashboard for distribution of answers'}},
  {'name': 'Information Service', 'description': 'Answer people\'s questions', 'details': {'Needs' : 'Response protocol, Labelling team, Safeguarding response', 'Produces' : 'Thematic distribution, work rate tracker'}},
  {'name': 'Bulk Message', 'description': 'Send set of people a once off message', 'details': {'Needs' : 'Definition of who. Safeguarding response', 'Produces' : 'Success/Fail tracker'}},
];
class User {
  String userName;
  String userEmail;
}
