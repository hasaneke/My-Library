abstract class AppTranslation {
  static Map<String, Map<String, String>> translationKeys = {
    'en_US': enUs,
    'tr': trTR
  };
}

final Map<String, String> enUs = {
  'my_library': 'My Library',
  'login_intro': 'Welcome to Your Library',
  'email': 'E-mail',
  'password': 'Password',
  'password_again': 'Password Again',
  'not_registered_yet?': 'Not registered yet?',
  'sign_up': 'Sign Up',
  'sign_in': 'Sign in',
  'sign_out': 'Sign Out',
  'sign_in_with_google': 'Sign in with Google',
  'sign_up_intro': 'FIRST STEP TO YOUR NEW LIBRARY',
  /* Errors part */
  'enter_a_password': 'Enter a password',
  'weak_password': 'Weak password',
  'password_are_not_matched': 'Passwords are not matched',
  'weak_password_message': 'Password must be at least 6 charchters long',
  'email_already_in_use': 'Email already in use',
  'enter_a_valid_email': 'Enter a valid email',
  /* ROOT APP SCREEN */
  'home_tab': 'Home',
  'marked_tab': 'Marked',
  'all_cards_tab': 'All',
  /* ADD CATEGORY DIALOG */
  'add_category_title': 'Add Category',
  'category_title': 'Title',
  'pick_a_color': 'Pick a color',
  'add_category': 'Add',
  /* DRAWER */
  'settings': 'Settings',
  /* Settings screen */
  'change_theme': 'Change Theme',
  'change_font_style': 'Change font style',
  /*POP UP MENU*/
  'edit': 'Edit',
  'delete': 'Delete',
  'add': 'Add',
  /* ADD ITEM SCREEN */
  'title': 'Title',
  'short_exp': 'Short Explanation',
  'long_exp': 'Long explanation',
  'add_card': 'Add Card',
  /* LOGIN ERRORS */
  'wrong_password': 'Wrong Password',
};

final Map<String, String> trTR = {
  /* UI PART */
  'my_library': 'Kütüphanem',
  'login_intro': 'Kütüphanene Hoşgeldin',
  'sign_up_intro': 'YENİ KÜTÜPHANENE İLK ADIM',
  /* AUTH PART*/
  'email': 'E-posta',
  'password': 'Şifre',
  'password_again': 'Tekrar Şifre',
  'not_registered_yet?': 'Henüz kayıt olmadın mı?',
  'sign_up': 'Kayıt ol',
  'sign_in': 'Giriş Yap',
  'sign_out': 'Çıkış Yap',
  'sign_in_with_google': 'Google hesabın ile giriş yap',
  /* ERRORS PART */
  'enter_a_password': 'Bir şifre gir',
  'weak_password': 'Zayıf şifre',
  'password_are_not_matched': 'Şifreler eşleşmedi',
  'weak_password_message': 'Şifre en az 6 karakter uzunluğunda olmalı',
  'email_already_in_use': 'E-posta zaten kullanılıyor',
  'enter_a_valid_email': 'Geçerli bir e-posta giriniz',
  /* ROOT APP SCREEN */
  'home_tab': 'Ana sayfa',
  'marked_tab': 'Marked',
  'all_cards_tab': 'Tüm Kartlar',
  /* ADD CATEGORY DIALOG */
  'add_category_title': 'Kategori Ekle',
  'category_title': 'Başlık',
  'pick_a_color': 'Renk seç',
  'add_category': 'Add',
  /* DRAWER */
  'settings': 'Ayarlar',
  /* Settings screen */
  'change_theme': 'Tema Değiştir',
  'change_font_style': 'Font tarzını değiştir',
  /*POP UP MENU*/
  'edit': 'Düzenle',
  'delete': 'Sil',
  'add': 'Ekle',
  /* ADD ITEM SCREEN*/
  'title': 'Başlık',
  'short_exp': 'Kısa Açıklama',
  'long_exp': 'Uzun Açıklama',
  'add_card': 'Kart Ekle',
  /* LOGIN ERRORS */
  'wrong_password': 'yanlış şifre',
};
