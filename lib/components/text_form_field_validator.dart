String? Function(String?)? textFormFieldValidator(String errorMessage) {
    return (String? value) {
      if (value?.isEmpty ?? true) {
        return errorMessage;
      }
      return null;
    };    
  }