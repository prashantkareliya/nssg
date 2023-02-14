class AddQuoteFields {
  bool? success;
  Result? result;

  AddQuoteFields({this.success, this.result});

  AddQuoteFields.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
        json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Quotestage>? quotestage;
  List<HdnTaxType>? hdnTaxType;
  List<QuotesTerms>? quotesTerms;
  List<GradeNumber>? gradeNumber;
  List<SystemType>? systemType;
  List<SignallingType>? signallingType;
  List<PremisesType>? premisesType;
  List<QuotesPayment>? quotesPayment;
  List<QuoteQuoteType>? quoteQuoteType;
  List<QuotePriorityLevel>? quotePriorityLevel;
  List<QuoteWorksSchedule>? quoteWorksSchedule;
  List<QuoteNoOfEngineer>? quoteNoOfEngineer;
  List<QuoteReqToCompleteWork>? quoteReqToCompleteWork;

  Result(
      {this.quotestage,
      this.hdnTaxType,
      this.quotesTerms,
      this.gradeNumber,
      this.systemType,
      this.signallingType,
      this.premisesType,
      this.quotesPayment,
      this.quoteQuoteType,
      this.quotePriorityLevel,
      this.quoteWorksSchedule,
      this.quoteNoOfEngineer,
      this.quoteReqToCompleteWork});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['quotestage'] != null) {
      quotestage = <Quotestage>[];
      json['quotestage'].forEach((v) {
        quotestage!.add(Quotestage.fromJson(v));
      });
    }
    if (json['hdnTaxType'] != null) {
      hdnTaxType = <HdnTaxType>[];
      json['hdnTaxType'].forEach((v) {
        hdnTaxType!.add(HdnTaxType.fromJson(v));
      });
    }
    if (json['quotes_terms'] != null) {
      quotesTerms = <QuotesTerms>[];
      json['quotes_terms'].forEach((v) {
        quotesTerms!.add(QuotesTerms.fromJson(v));
      });
    }
    if (json['grade_number'] != null) {
      gradeNumber = <GradeNumber>[];
      json['grade_number'].forEach((v) {
        gradeNumber!.add(GradeNumber.fromJson(v));
      });
    }
    if (json['system_type'] != null) {
      systemType = <SystemType>[];
      json['system_type'].forEach((v) {
        systemType!.add(SystemType.fromJson(v));
      });
    }
    if (json['signalling_type'] != null) {
      signallingType = <SignallingType>[];
      json['signalling_type'].forEach((v) {
        signallingType!.add(SignallingType.fromJson(v));
      });
    }
    if (json['premises_type'] != null) {
      premisesType = <PremisesType>[];
      json['premises_type'].forEach((v) {
        premisesType!.add(PremisesType.fromJson(v));
      });
    }
    if (json['quotes_payment'] != null) {
      quotesPayment = <QuotesPayment>[];
      json['quotes_payment'].forEach((v) {
        quotesPayment!.add(QuotesPayment.fromJson(v));
      });
    }
    if (json['quote_quote_type'] != null) {
      quoteQuoteType = <QuoteQuoteType>[];
      json['quote_quote_type'].forEach((v) {
        quoteQuoteType!.add(QuoteQuoteType.fromJson(v));
      });
    }
    if (json['quote_priority_level'] != null) {
      quotePriorityLevel = <QuotePriorityLevel>[];
      json['quote_priority_level'].forEach((v) {
        quotePriorityLevel!.add(QuotePriorityLevel.fromJson(v));
      });
    }
    if (json['quote_works_schedule'] != null) {
      quoteWorksSchedule = <QuoteWorksSchedule>[];
      json['quote_works_schedule'].forEach((v) {
        quoteWorksSchedule!.add(QuoteWorksSchedule.fromJson(v));
      });
    }
    if (json['quote_no_of_engineer'] != null) {
      quoteNoOfEngineer = <QuoteNoOfEngineer>[];
      json['quote_no_of_engineer'].forEach((v) {
        quoteNoOfEngineer!.add(QuoteNoOfEngineer.fromJson(v));
      });
    }
    if (json['quote_req_to_complete_work'] != null) {
      quoteReqToCompleteWork = <QuoteReqToCompleteWork>[];
      json['quote_req_to_complete_work'].forEach((v) {
        quoteReqToCompleteWork!.add(QuoteReqToCompleteWork.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quotestage != null) {
      data['quotestage'] = quotestage!.map((v) => v.toJson()).toList();
    }
    if (hdnTaxType != null) {
      data['hdnTaxType'] = hdnTaxType!.map((v) => v.toJson()).toList();
    }
    if (quotesTerms != null) {
      data['quotes_terms'] = quotesTerms!.map((v) => v.toJson()).toList();
    }
    if (gradeNumber != null) {
      data['grade_number'] = gradeNumber!.map((v) => v.toJson()).toList();
    }
    if (systemType != null) {
      data['system_type'] = systemType!.map((v) => v.toJson()).toList();
    }
    if (signallingType != null) {
      data['signalling_type'] =
          signallingType!.map((v) => v.toJson()).toList();
    }
    if (premisesType != null) {
      data['premises_type'] =
          premisesType!.map((v) => v.toJson()).toList();
    }
    if (quotesPayment != null) {
      data['quotes_payment'] =
          quotesPayment!.map((v) => v.toJson()).toList();
    }
    if (quoteQuoteType != null) {
      data['quote_quote_type'] =
          quoteQuoteType!.map((v) => v.toJson()).toList();
    }
    if (quotePriorityLevel != null) {
      data['quote_priority_level'] =
          quotePriorityLevel!.map((v) => v.toJson()).toList();
    }
    if (quoteWorksSchedule != null) {
      data['quote_works_schedule'] =
          quoteWorksSchedule!.map((v) => v.toJson()).toList();
    }
    if (quoteNoOfEngineer != null) {
      data['quote_no_of_engineer'] =
          quoteNoOfEngineer!.map((v) => v.toJson()).toList();
    }
    if (quoteReqToCompleteWork != null) {
      data['quote_req_to_complete_work'] =
          quoteReqToCompleteWork!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quotestage {
  String? label;
  String? value;

  Quotestage({this.label, this.value});

  Quotestage.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class HdnTaxType {
  String? label;
  String? value;

  HdnTaxType({this.label, this.value});

  HdnTaxType.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class QuotesTerms {
  String? label;
  String? value;

  QuotesTerms({this.label, this.value});

  QuotesTerms.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class GradeNumber {
  String? label;
  String? value;

  GradeNumber({this.label, this.value});

  GradeNumber.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class SystemType {
  String? label;
  String? value;

  SystemType({this.label, this.value});

  SystemType.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class SignallingType {
  String? label;
  String? value;

  SignallingType({this.label, this.value});

  SignallingType.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class PremisesType {
  String? label;
  String? value;

  PremisesType({this.label, this.value});

  PremisesType.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class QuotesPayment {
  String? label;
  String? value;

  QuotesPayment({this.label, this.value});

  QuotesPayment.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class QuoteQuoteType {
  String? label;
  String? value;

  QuoteQuoteType({this.label, this.value});

  QuoteQuoteType.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class QuotePriorityLevel {
  String? label;
  String? value;

  QuotePriorityLevel({this.label, this.value});

  QuotePriorityLevel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class QuoteWorksSchedule {
  String? label;
  String? value;

  QuoteWorksSchedule({this.label, this.value});

  QuoteWorksSchedule.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class QuoteNoOfEngineer {
  String? label;
  String? value;

  QuoteNoOfEngineer({this.label, this.value});

  QuoteNoOfEngineer.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class QuoteReqToCompleteWork {
  String? label;
  String? value;

  QuoteReqToCompleteWork({this.label, this.value});

  QuoteReqToCompleteWork.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}
