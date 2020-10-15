import 'dart:convert';
import 'dart:html';

import 'logger.dart';
import 'controller.dart' as controller;

Logger log = new Logger('view.dart');

Element get headerElement => querySelector('header');
Element get mainElement => querySelector('main');
Element get footerElement => querySelector('footer');

NavView navView;
ContentView contentView;

void init() {
  navView = new NavView();
  contentView = new ContentView();
  headerElement.append(navView.navViewElement);
  mainElement.append(contentView.contentViewElement);
}

class NavView {
  DivElement navViewElement;
  DivElement _appLogos;
  DivElement _projectTitle;
  AuthHeaderViewPartial authHeaderViewPartial;


  NavView() {
    navViewElement = new DivElement()
      ..classes.add('nav');
    _appLogos = new DivElement()
      ..classes.add('nav__app-logo')
      ..append(new ImageElement(src: 'assets/africas-voices-logo.svg'));
    _projectTitle = new DivElement()
      ..classes.add('nav__project-title');
    authHeaderViewPartial = new AuthHeaderViewPartial();

    navViewElement.append(_appLogos);
    navViewElement.append(_projectTitle);
    navViewElement.append(authHeaderViewPartial.authElement);
  }

  void set projectTitle(String projectName) => _projectTitle.text = projectName;
}

class AuthHeaderViewPartial {
  DivElement authElement;
  DivElement _userPic;
  DivElement _userName;
  ButtonElement _signOutButton;
  ButtonElement _signInButton;

  AuthHeaderViewPartial() {
    authElement = new DivElement()
      ..classes.add('auth-header');

    _userPic = new DivElement()
      ..classes.add('auth-header__user-pic');
    authElement.append(_userPic);

    _userName = new DivElement()
      ..classes.add('auth-header__user-name');
    authElement.append(_userName);

    _signOutButton = new ButtonElement()
      ..text = 'Sign out'
      ..onClick.listen((_) => controller.command(controller.UIAction.signOutButtonClicked, null));
    authElement.append(_signOutButton);

    _signInButton = new ButtonElement()
      ..text = 'Sign in'
      ..onClick.listen((_) => controller.command(controller.UIAction.signInButtonClicked, null));
    authElement.append(_signInButton);
  }

  void signIn(String userName, userPicUrl) {
    // Set the user's profile pic and name
    _userPic.style.backgroundImage = 'url($userPicUrl)';
    _userName.text = userName;

    // Show user's profile pic, name and sign-out button.
    _userName.attributes.remove('hidden');
    _userPic.attributes.remove('hidden');
    _signOutButton.attributes.remove('hidden');

    // Hide sign-in button.
    _signInButton.setAttribute('hidden', 'true');
  }

  void signOut() {
    // Hide user's profile pic, name and sign-out button.
    _userName.attributes['hidden'] = 'true';
    _userPic.attributes['hidden'] = 'true';
    _signOutButton.attributes['hidden'] = 'true';

    // Show sign-in button.
    _signInButton.attributes.remove('hidden');
  }
}

class ContentView {
  DivElement contentViewElement;
  AuthMainView authMainView;
  DashboardView dashboardView;
  BatchRepliesConfigurationView batchRepliesConfigurationView;
  EscalatesConfigurationView escalatesConfigurationView;
  ProjectConfigurationView projectConfigurationView;

  ContentView() {
    contentViewElement = new DivElement()..classes.add('content');
    authMainView = new AuthMainView();
    dashboardView = new DashboardView();
    batchRepliesConfigurationView = new BatchRepliesConfigurationView();
    escalatesConfigurationView = new EscalatesConfigurationView();
    projectConfigurationView = new ProjectConfigurationView();
  }

  void renderView(DivElement view) {
    contentViewElement.children.clear();
    contentViewElement.append(view);
  }
}

class AuthMainView {
  DivElement authElement;
  ButtonElement _signInButton;

  final descriptionText1 = 'Sign in to Katikati';
  final descriptionText2 = 'Please contact Africa\'s Voices for login details.';

  AuthMainView() {
    authElement = new DivElement()
      ..classes.add('auth-main');

    var logosContainer = new DivElement()
      ..classes.add('auth-main__logos');
    authElement.append(logosContainer);

    var avfLogo = new ImageElement(src: 'assets/africas-voices-logo.svg')
      ..classes.add('auth-main__partner-logo');
    logosContainer.append(avfLogo);

    var shortDescription = new DivElement()
      ..classes.add('auth-main__project-description')
      ..append(new ParagraphElement()..text = descriptionText1)
      ..append(new ParagraphElement()..text = descriptionText2);
    authElement.append(shortDescription);

    _signInButton = new ButtonElement()
      ..text = 'Sign in'
      ..onClick.listen((_) => controller.command(controller.UIAction.signInButtonClicked, null));
    authElement.append(_signInButton);
  }
}

class DashboardView {
  List<ActivePackagesViewPartial> activePackages;
  List<AvailablePackagesViewPartial> availablepackages;

  DivElement dashboardViewElement;
  DivElement _projectActionsContainer;
  AnchorElement _conversationsLink;
  AnchorElement _oversightDashboardLink;
  DivElement activePackagesContainer;
  DivElement availablePackagesContainer;

  DashboardView() {
    activePackages = [];
    availablepackages = [];
    dashboardViewElement = new DivElement()..classes.add('dashboard');
    _projectActionsContainer = new DivElement()
      ..classes.add('dashboard__project-actions');
    _conversationsLink = new AnchorElement()
      ..classes.add('dashboard__project-actions-link')
      ..text = "Go to conversations"
      ..href = "#";
    _oversightDashboardLink = new AnchorElement()
      ..classes.add('dashboard__project-actions-link')
      ..text = "Go to oversight dashboard"
      ..href = "#";
    activePackagesContainer = new DivElement()
      ..classes.add('active-packages');
    availablePackagesContainer = new DivElement()
      ..classes.add('available-packages');

    _projectActionsContainer.append(_conversationsLink);
    _projectActionsContainer.append(_oversightDashboardLink);
    dashboardViewElement.append(_projectActionsContainer);
    dashboardViewElement.append(activePackagesContainer);
    dashboardViewElement.append(availablePackagesContainer);
  }

  void renderActivePackages() {
    activePackagesContainer.children.clear();
    activePackagesContainer.append(new HeadingElement.h1()..text = "Active packages");
    if (activePackages.isNotEmpty) {
      activePackages.forEach((package) => activePackagesContainer.append(package.packageElement));
    }
  }

  void renderAvailablePackages() {
    availablePackagesContainer.children.clear();
    availablePackagesContainer.append(new HeadingElement.h1()..text = "Add a package");
    if (activePackages.isNotEmpty) {
      availablepackages.forEach((package) => availablePackagesContainer.append(package.packageElement));
    }
  }
}

enum FormGroupTypes {
  TEXT,
  CHECKBOX,
  DATE
}

enum ProjectConfigurationSections {
  PROJECT_LANGUAGES,
  USER_CONFIGURATION
}

class ProjectConfigurationView {
  DivElement configurationViewElement;
  FormElement _projectConfigurationForm;

  ProjectConfigurationView() {
    configurationViewElement = new DivElement()
      ..classes.add('project-configuration');
    _projectConfigurationForm = new FormElement()
      ..classes.add('configuration-form');
    _buildForm();
    configurationViewElement.append(_projectConfigurationForm);
  }

  void _buildForm() {
    _projectConfigurationForm
      ..append(
        _multipleFormGroup('Project Languages:', ProjectConfigurationSections.PROJECT_LANGUAGES.toString(),
          {'English': {'send': FormGroupTypes.CHECKBOX, 'receive': FormGroupTypes.CHECKBOX },
            'Somali': {'send': FormGroupTypes.CHECKBOX, 'receive': FormGroupTypes.CHECKBOX }})
      )
      ..append(
        _singleFormGroup('Automated translations enabled', FormGroupTypes.CHECKBOX)
      )
      ..append(
        _singleFormGroup('Coda dataset regex', FormGroupTypes.TEXT)
      )
      ..append(
        _singleFormGroup('Rapidpro token', FormGroupTypes.TEXT)
      )
      ..append(
        _singleFormGroup('Project start date', FormGroupTypes.DATE)
      )
      ..append(
        _multipleFormGroup('User Configuration:', ProjectConfigurationSections.USER_CONFIGURATION.toString(),
          {'person1@africasvoices.org:':
            {'can see messages': FormGroupTypes.CHECKBOX,
              'can perform translations': FormGroupTypes.CHECKBOX,
              'can send messages': FormGroupTypes.CHECKBOX,
              'can send custom messages': FormGroupTypes.CHECKBOX,
              'can approve actions': FormGroupTypes.CHECKBOX,
              'can configure the project': FormGroupTypes.CHECKBOX
            },
          'person2@africasvoices.org:':
            {'can see messages': FormGroupTypes.CHECKBOX,
              'can perform translations': FormGroupTypes.CHECKBOX,
              'can send messages': FormGroupTypes.CHECKBOX,
              'can send custom messages': FormGroupTypes.CHECKBOX,
              'can approve actions': FormGroupTypes.CHECKBOX,
              'can configure the project': FormGroupTypes.CHECKBOX
            },
          'person3@africasvoices.org:':
            {'can see messages': FormGroupTypes.CHECKBOX,
              'can perform translations': FormGroupTypes.CHECKBOX,
              'can send messages': FormGroupTypes.CHECKBOX,
              'can send custom messages': FormGroupTypes.CHECKBOX,
              'can approve actions': FormGroupTypes.CHECKBOX,
              'can configure the project': FormGroupTypes.CHECKBOX
            },
          'person4@africasvoices.org:':
            {'can see messages': FormGroupTypes.CHECKBOX,
              'can perform translations': FormGroupTypes.CHECKBOX,
              'can send messages': FormGroupTypes.CHECKBOX,
              'can send custom messages': FormGroupTypes.CHECKBOX,
              'can approve actions': FormGroupTypes.CHECKBOX,
              'can configure the project': FormGroupTypes.CHECKBOX
            }
          })
      );
  }

  DivElement _singleFormGroup(String label, FormGroupTypes formGroupType) {
    var formGroup = new DivElement()
      ..classes.add('single-form-group');
    var labelElement = new LabelElement()
      ..classes.add('single-form-group__label')
      ..text = label;
    var formElement = new InputElement()
      ..classes.add('single-form-group__input')
      ..type = formGroupType.toString().split('.').last;
    if (formGroupType == FormGroupTypes.CHECKBOX) {
      formGroup
      ..append(formElement)
      ..append(labelElement);
    } else {
      formElement.classes.add('single-form-group__input--is-text');
      formGroup
      ..append(labelElement)
      ..append(formElement);
    }
    return formGroup;
  }

  DivElement _multipleFormGroup(String groupLabel, String section, Map<String, Map<String, FormGroupTypes>> groupElements) {
    var formGroup = new DivElement()
      ..classes.add('multi-form-group')
      ..setAttribute('section', section);
    var formGroupLabel = new LabelElement()
      ..classes.add('multi-form-group__label')
      ..text = groupLabel;
    formGroup.append(formGroupLabel);
    groupElements.forEach((label, elementGroups) {
      var formElementGroups = new DivElement()
        ..classes.add('multi-form-group-elements');
      var elementGroupLabel = new LabelElement()
        ..classes.add('multi-form-group-elements__label')
        ..text = label;
      formElementGroups.append(elementGroupLabel);
      elementGroups.forEach((label, formGroupType) {
        var formElementGroup = _singleFormGroup(label, formGroupType)
          ..classes.add('single-form-group--in-multi');
        formElementGroups.append(formElementGroup);
      });
      formElementGroups.append(
        new ButtonElement()
        ..classes.addAll(['close-button', 'multi-form-group__button-remove'])
        ..text = 'x'
        ..onClick.listen((event) {
          event.preventDefault();
          var formGroup = (event.target as Element).parent;
          var section = formGroup.parent.attributes['section'];
          if (section == ProjectConfigurationSections.PROJECT_LANGUAGES.toString()) {
            controller.command(controller.UIAction.removeProjectConfigurationLanguage,
              new controller.ProjectConfigurationLanguage(language: formGroup.firstChild.text.trim()));
          } else if (section == ProjectConfigurationSections.USER_CONFIGURATION.toString()) {
            controller.command(controller.UIAction.removeProjectConfigurationUser,
              new controller.ProjectConfigurationUser(user: formGroup.firstChild.text.trim()));
          }
          formGroup.remove();
        })
      );
      formGroup.append(formElementGroups);
    });
    return formGroup;
  }
}

class ActivePackagesViewPartial {
  DivElement packageElement;
  HeadingElement _packageName;
  DivElement _packageActionsContainer;
  AnchorElement _dashboardAction;
  AnchorElement _conversationsAction;
  AnchorElement _configureAction;

  ActivePackagesViewPartial(String packageName) {
    packageElement = new DivElement()
      ..classes.add('active-packages__package');
    _packageName = new HeadingElement.h4()
      ..text = '$packageName (Active)';
    _packageActionsContainer = new DivElement()
      ..classes.add('active-packages__package-actions');
    _dashboardAction = new AnchorElement()
      ..classes.add('active-packages__package-action')
      ..text = 'Dashboard'
      ..href = '#/dashboard';
    _conversationsAction = new AnchorElement()
      ..classes.add('active-packages__package-action')
      ..text = 'Conversations'
      ..href = '#/conversations';
    _configureAction = new AnchorElement()
      ..classes.add('active-packages__package-action')
      ..text = 'Configure'
      ..href = '#/batch-replies-configuration';
    _packageActionsContainer.append(_dashboardAction);
    _packageActionsContainer.append(_conversationsAction);
    _packageActionsContainer.append(_configureAction);
    packageElement.append(_packageName);
    packageElement.append(_packageActionsContainer);
  }
}

class AvailablePackagesViewPartial {
  DivElement packageElement;
  DivElement _addPackageLinkContainer;
  AnchorElement _addPackageLink;
  DivElement _descriptionContaner;
  HeadingElement _descriptionTitle;
  DivElement _descriptionDetails;

  AvailablePackagesViewPartial(String packageName, String descriptionTitle, List<String> descriptionDetails) {
    packageElement = new DivElement()
      ..classes.add('available-packages__package');
    _addPackageLinkContainer = new DivElement()
      ..classes.add('available-packages__add-package');
    _addPackageLink = new AnchorElement()
      ..classes.add('available-packages__add-package-link')
      ..text = packageName
      ..href = '#';
    _descriptionContaner = new DivElement()
      ..classes.add('available-packages__package-description');
    _descriptionTitle = new HeadingElement.h4()
      ..text = descriptionTitle;
    _descriptionDetails = new DivElement();
    descriptionDetails.forEach((detail) => _descriptionDetails.append(new ParagraphElement()..text = detail));

    _addPackageLinkContainer.append(_addPackageLink);
    _descriptionContaner.append(_descriptionTitle);
    _descriptionContaner.append(_descriptionDetails);
    packageElement.append(_addPackageLinkContainer);
    packageElement.append(_descriptionContaner);
  }
}

class BatchRepliesConfigurationView {
  DivElement configurationViewElement;
  DivElement _tagsContainer;
  ConfigurationViewTagListPartial tagList;
  ConfigurationViewTagResponsesPartial tagResponses;

  BatchRepliesConfigurationView() {
    configurationViewElement = new DivElement()
      ..classes.add('configure-package');
    _tagsContainer = new DivElement()
      ..classes.add('configure-package__tags');
    tagList = new ConfigurationViewTagListPartial();
    tagResponses = new ConfigurationViewTagResponsesPartial();

    _tagsContainer.append(tagList.tagListElement);
    _tagsContainer.append(tagResponses.tagResponsesElement);
    configurationViewElement.append(HeadingElement.h2()
      ..classes.add('configure-package__title')
      ..text = "Batch replies (Week 12) package");
    configurationViewElement.append(HeadingElement.h3()
      ..classes.add('configure-package__sub-title')
      ..text = "Configure");
    configurationViewElement.append(_tagsContainer);
  }
}

class EscalatesConfigurationView {
  DivElement configurationViewElement;
  DivElement _tagsContainer;
  ConfigurationViewTagListPartial tagList;
  ConfigurationViewTagResponsesPartial tagResponses;

  EscalatesConfigurationView() {
    configurationViewElement = new DivElement()
      ..classes.add('configure-package');
    _tagsContainer = new DivElement()
      ..classes.add('configure-package__tags');
    tagList = new ConfigurationViewTagListPartial();
    tagResponses = new ConfigurationViewTagResponsesPartial();

    _tagsContainer.append(tagList.tagListElement);
    _tagsContainer.append(tagResponses.tagResponsesElement);
    configurationViewElement.append(HeadingElement.h2()
      ..classes.add('configure-package__title')
      ..text = "Escalates package");
    configurationViewElement.append(HeadingElement.h3()
      ..classes.add('configure-package__sub-title')
      ..text = "Configure");
    configurationViewElement.append(_tagsContainer);
  }
}

class ConfigurationViewTagListPartial {
  Element tagListElement;

  ConfigurationViewTagListPartial() {
    tagListElement = new Element.ul()
      ..classes.add('tags-list');
  }

  void renderTagList(Map<String, bool> tags) {
    tagListElement.children.clear();
    tags.forEach((tag, state) {
      var tagItem = new Element.li()
        ..classes.add('tag-list__tag-item')
        ..text = tag;
      tagItem.onClick.listen((event) {
        var selectedTag = (event.target as Element);
        controller.command(controller.UIAction.configurationTagSelected, new controller.ConfigurationTagData(selectedTag: selectedTag.text.trim()));
      });
      tagItem.onDragOver.listen((event) => event.preventDefault());
      tagItem.onDragEnter.listen((event) {
        event.preventDefault();
        (event.target as Element).classes.add('tag-list__tag-item-drop-target');
      });
      tagItem.onDragLeave.listen((event) => (event.target as Element).classes.remove('tag-list__tag-item-drop-target'));
      tagItem.onDrop.listen((event) {
        event.preventDefault();
        var dropTarget = (event.target as Element);
        dropTarget.classes.remove('tag-list__tag-item-drop-target');
        if (dropTarget.classes.contains('tag-list__tag-item')) {
          var responseData = jsonDecode(event.dataTransfer.getData("Text"));
          responseData.forEach((language, text) {
            controller.command(controller.UIAction.addConfigurationResponseEntries,
              new controller.ConfigurationResponseData(parentTag: dropTarget.text, language: language, text: text));
          });
        }
      });
      tagListElement.append(tagItem);
    });
    toggleTagsSelectedState(tags);
    tagListElement.append(
      new ButtonElement()
        ..classes.add('add-button')
        ..text = '+'
        ..onClick.listen((event) => tagListElement.append(addTagDropDown(controller.additionalConfigurationTags.toList())))
    );
  }

  DivElement addTagDropDown(List<String> tags) {
    var addTagModal = new DivElement()
      ..classes.add('add-tag-modal');
    addTagModal.append(
      HeadingElement.h6()
        ..classes.add('add-tag-modal__heading')
        ..text = 'Select new tag to add');
    addTagModal.append(
      new ButtonElement()
        ..classes.addAll(['close-button', 'add-tag-modal__close-button'])
        ..text = 'x'
        ..onClick.listen((_) => addTagModal.remove()));
    var tagOptions = new SelectElement()
      ..classes.add('add-tag-modal__dropdown')
      ..onChange.listen((event) {
        var selectedOption = (event.currentTarget as SelectElement).value;
        controller.command(controller.UIAction.addConfigurationTag, new controller.ConfigurationTagData(tagToAdd: selectedOption));
        if(tagListElement.children.last is DivElement) tagListElement.children.removeLast();
      });
    tagOptions.add(new OptionElement()..text = '-', false);
    tags.forEach((tag) {
      var option = new OptionElement()
        ..text = tag
        ..value = tag;
      tagOptions.add(option, false);
    });
    addTagModal.append(tagOptions);
    return addTagModal;
  }

  void toggleTagsSelectedState(Map<String, bool> tags) {
    tagListElement.children.forEach((tag) {
      tag.classes.toggle('tag-list__tag-item--active', tags[tag.text]);
    });
  }
}

class ConfigurationViewTagResponsesPartial {
  DivElement tagResponsesElement;
  DivElement _tagResponsesHeader;
  DivElement _tagResponsesBody;

  ConfigurationViewTagResponsesPartial() {
    tagResponsesElement = new DivElement()
      ..classes.add('tag-responses');
    _tagResponsesHeader = new DivElement()
      ..classes.add('tag-responses__header');
    _tagResponsesBody = new DivElement()
      ..classes.add('tag-responses__content');
  }

  void renderResponses(String tag, List<String> responseLanguages, List<List<String>> responses) {
    tagResponsesElement.children.clear();
    _tagResponsesHeader.children.clear();
    _tagResponsesBody.children.clear();
    responseLanguages.forEach((lang) => _tagResponsesHeader.append(
      new HeadingElement.h5()
        ..classes.add('tag-responses__header-title')
        ..text = lang
    ));
    for (int i = 0; i < responses.length; i++) {
      var item = new DivElement()
          ..classes.add('tag-responses__item-row')
          ..append(
            new DivElement()
            ..draggable = true
            ..classes.add('tag-responses__item-drag-handle')
            ..onDragStart.listen((event) {
              var handle = event.target as Element;
              var parent = handle.parent;
              handle.classes.add('tag-responses__item-drag-handle_dragging');
              Map<String, String> payload = {};
              for (int k = 1; k < parent.children.length; k++) {
                payload[parent.children[k].attributes['language']] = parent.children[k].text;
              }
              event.dataTransfer.setData("Text", jsonEncode(payload));
            })
            ..onDragEnd.listen((event) => (event.target as Element).classes.remove('tag-responses__item-drag-handle_dragging'))
          );
      for (int j = 0; j < responses[i].length; j++) {
        item.append(
            new ParagraphElement()
              ..classes.add('tag-responses__item')
              ..attributes.addAll({'contenteditable': 'true', 'parent-tag': tag, 'language': responseLanguages[j] ,'index': '$i'})
              ..text = responses[i][j]
              ..draggable = true
              ..onBlur.listen((event) {
                var reponseElement = (event.currentTarget as Element);
                var parentTag = reponseElement.attributes['parent-tag'];
                var index = int.parse(reponseElement.attributes['index']);
                var language = reponseElement.attributes['language'];
                var text = reponseElement.text;
                controller.command(controller.UIAction.editConfigurationTagResponse, new controller.ConfigurationResponseData(parentTag: parentTag, index: index, language: language, text: text));
          }));
        _tagResponsesBody.append(item);
      }
    }
    tagResponsesElement.append(_tagResponsesHeader);
    tagResponsesElement.append(_tagResponsesBody);
    tagResponsesElement.append(
      new ButtonElement()
          ..classes.add('add-button')
          ..text = '+'
          ..onClick.listen((event) {
            controller.command(controller.UIAction.addConfigurationResponseEntries, new controller.ConfigurationResponseData(parentTag: tag));
            window.scrollTo(0, mainElement.scrollHeight);
          })
    );
  }
}
