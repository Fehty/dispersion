// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);

  static _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("Dispersion"),
        "exit": MessageLookupByLibrary.simpleMessage("Exit"),
        "info": MessageLookupByLibrary.simpleMessage("Information"),
        "infoText": MessageLookupByLibrary.simpleMessage(
            "Light is an electromagnetic wave. Visible light is a wave that has a length in the range from 380 to 760 nanometers (from purple to red), inclusive.\n\nAs early as 1672, Newton noticed that the refractive index depends on the wavelength. In other words, red light falling on the surface and being refracted will deviate to a different angle than yellow, green, and so on. This dependence is called variance.\n\nThe rainbow is the result of dispersion!\n\nBy passing white light through a prism, you can get a spectrum consisting of all the colors of the rainbow. This phenomenon is directly explained by the dispersion of light. If the refractive index depends on the wavelength, then it also depends on the frequency. Accordingly, the speed of light for different wavelengths in the substance will also be different.\n\nDispersion of light – the dependence of the speed of light in a substance on frequency.\n\nWhere there is dispersion of light? In many areas! For example, in art(rainbow), industry(paints, additives for fabrics), household chemicals (starches). You can also observe the color \"play of light\" on the edges of the diamond, if we are talking about jewelry.\n\nThe dispersion of light is an interesting physical phenomenon that nature has given us!"),
        "monoLight": MessageLookupByLibrary.simpleMessage("Monochrome"),
        "nm": MessageLookupByLibrary.simpleMessage("nm"),
        "whiteLight": MessageLookupByLibrary.simpleMessage("White light")
      };
}
