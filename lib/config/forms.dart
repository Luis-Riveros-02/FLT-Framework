import 'inputs_core/validators.dart';
import 'inputs_core/connectForms.dart';
import '../Internals/logic_provider.dart';
import '../config/models.dart';


class PersonForm extends BaseForm {
  final Text_Input name = Text_Input(name: 'Name', noNull: true,showCounter: true,maxLength:20, placeholder: 'Enter full name');
  final Number_Field age = Number_Field(name: 'Age', noNull: true, min: 0, max: 120, placeholder: 'Enter age');
  final Float_Field height = Float_Field(name: 'Height', min: 0.5, max: 3.0, placeholder: 'Enter height in meters', noNull: true);
  final Password_Input password = Password_Input(name: 'Password', noNull: true, minLength: 6, maxLength: 20, showCounter: true, placeholder: 'Enter password');
  final Email_Input email = Email_Input(name: 'Email', noNull: true, showCounter: true, maxLength: 40, placeholder: 'Enter email address');
  final Date_Input birthDate = Date_Input(name: 'Birth Date', noNull: true, minDate: DateTime(1900), maxDate: DateTime.now());
  final Time_Input appointmentTime = Time_Input(name: 'Appointment Time', noNull: true);
  final Phone_Input phone = Phone_Input(name: 'Teléfono', noNull: true, placeholder: "Enter your phone number");
  final Dropdown_Input gender = Dropdown_Input(name:"Gender",values:["male","female","other"], noNull: true, placeholder:"Enter your gender");
  final Radio_Input boolRadio = Radio_Input(name: "Are you a student?", values: ["yes", "no"], noNull: true);
  final TextArea_Input bio = TextArea_Input(name: 'Bio', noNull: true, maxLength: 250, placeholder: 'Tell us about yourself', heightScale: 4);
  final Checkbox_Input acceptTerms = Checkbox_Input(name: 'Accept Terms', noNull: true, initialValue: false);
  final Checkbox_Multi_Input hobbies = Checkbox_Multi_Input(name: 'Hobbies', values: ['Reading', 'Traveling', 'Cooking', 'Sports'], noNull: true, initialValue: ['Traveling', 'Sports']);
  final File_Input profilePicture = File_Input(name: 'Profile Picture', noNull: true, allowedExtensions: ['jpg','png','txt','csv','xml'], maxFiles: 3, placeholder: "Insert your profile image");

  PersonForm({super.visualForm, int columnsInputs = 2})
      : super(formTitle: "Form person", columnsInputs: columnsInputs);

  @override
  List<ValidatorField> get fields => [age, name, height, password, email, birthDate, appointmentTime, phone, gender, boolRadio, bio, hobbies, profilePicture, acceptTerms];

  @override
  void successfulEvent(AppProvider app) {
    print("Formulario validado correctamente!");
    app.setPerson(Person(age: age.value, name: name.value, height: height.value));
    app.navigateTo('/boolradio');
  }

  @override
  void errorEvent(AppProvider app) {
    print("Errores en el formulario:");
  }

}