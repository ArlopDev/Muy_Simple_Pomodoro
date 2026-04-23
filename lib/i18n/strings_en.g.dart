///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsTimerEn timer = TranslationsTimerEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
	late final TranslationsLanguageEn language = TranslationsLanguageEn._(_root);
}

// Path: timer
class TranslationsTimerEn {
	TranslationsTimerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Focus'
	String get work => 'Focus';

	/// en: 'Break'
	String get kBreak => 'Break';

	/// en: 'Long Break'
	String get longBreak => 'Long Break';

	/// en: 'Session'
	String get session => 'Session';

	/// en: 'Reset'
	String get reset => 'Reset';

	/// en: 'Skip'
	String get skip => 'Skip';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Focus Time'
	String get focusTime => 'Focus Time';

	/// en: 'Break Time'
	String get breakTime => 'Break Time';

	/// en: 'Long Break Time'
	String get longBreakTime => 'Long Break Time';

	/// en: 'Customize'
	String get customize => 'Customize';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Accept'
	String get accept => 'Accept';
}

// Path: language
class TranslationsLanguageEn {
	TranslationsLanguageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'English'
	String get english => 'English';

	/// en: 'Spanish'
	String get spanish => 'Spanish';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'timer.work' => 'Focus',
			'timer.kBreak' => 'Break',
			'timer.longBreak' => 'Long Break',
			'timer.session' => 'Session',
			'timer.reset' => 'Reset',
			'timer.skip' => 'Skip',
			'settings.title' => 'Settings',
			'settings.focusTime' => 'Focus Time',
			'settings.breakTime' => 'Break Time',
			'settings.longBreakTime' => 'Long Break Time',
			'settings.customize' => 'Customize',
			'settings.cancel' => 'Cancel',
			'settings.accept' => 'Accept',
			'language.english' => 'English',
			'language.spanish' => 'Spanish',
			_ => null,
		};
	}
}
