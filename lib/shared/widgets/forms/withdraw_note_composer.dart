abstract class WithdrawNoteComposer {
  static String? compose({required String note, required String account}) {
    final trimmedNote = note.trim();
    final trimmedAccount = account.trim();

    if (trimmedAccount.isEmpty) {
      return trimmedNote.isEmpty ? null : trimmedNote;
    }

    if (trimmedNote.isEmpty) return trimmedAccount;

    return '$trimmedAccount\n$trimmedNote';
  }
}
