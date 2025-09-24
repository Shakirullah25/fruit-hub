import 'package:flutter_test/flutter_test.dart';
import 'package:fruit_salad_combo/utils/validators.dart';
import 'package:fruit_salad_combo/widgets/primary_textfield.dart';

void main() {
  group("First Name Validation", () {
    test("Empty Name returns error", () {
      expect(validateName(""), "Name cannot be empty.");
    });
    test("Too long name", () {
      expect(validateName("A" * 30), "Name is too long.");
    });
    test("Valid name returns null", () {
      expect(
        validateName("Shakirullah123"),
        "Please use only letters and spaces.",
      );
    });
    // test("Hint Text Confirmation", () {
    //   expect(PrimaryTextField(hintText: ""), "Search for fruit salad combos");
    // });
  });
}
