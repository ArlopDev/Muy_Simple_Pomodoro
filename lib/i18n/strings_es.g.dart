///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEs with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsTimerEs timer = _TranslationsTimerEs._(_root);
	@override late final _TranslationsSettingsEs settings = _TranslationsSettingsEs._(_root);
	@override late final _TranslationsLanguageEs language = _TranslationsLanguageEs._(_root);
}

// Path: timer
class _TranslationsTimerEs implements TranslationsTimerEn {
	_TranslationsTimerEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get work => 'Enfoque';
	@override String get kBreak => 'Descanso';
	@override String get longBreak => 'Descanso Largo';
	@override String get session => 'Sesión';
	@override String get reset => 'Reiniciar';
	@override String get skip => 'Saltar';
}

// Path: settings
class _TranslationsSettingsEs implements TranslationsSettingsEn {
	_TranslationsSettingsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Opciones';
	@override String get focusTime => 'Tiempo Enfoque';
	@override String get breakTime => 'Tiempo Descanso';
	@override String get longBreakTime => 'Tiempo Descanso Largo';
	@override String get customize => 'Personalizar';
	@override String get cancel => 'Cancelar';
	@override String get accept => 'Aceptar';
}

// Path: language
class _TranslationsLanguageEs implements TranslationsLanguageEn {
	_TranslationsLanguageEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get english => 'Inglés';
	@override String get spanish => 'Español';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'timer.work' => 'Enfoque',
			'timer.kBreak' => 'Descanso',
			'timer.longBreak' => 'Descanso Largo',
			'timer.session' => 'Sesión',
			'timer.reset' => 'Reiniciar',
			'timer.skip' => 'Saltar',
			'settings.title' => 'Opciones',
			'settings.focusTime' => 'Tiempo Enfoque',
			'settings.breakTime' => 'Tiempo Descanso',
			'settings.longBreakTime' => 'Tiempo Descanso Largo',
			'settings.customize' => 'Personalizar',
			'settings.cancel' => 'Cancelar',
			'settings.accept' => 'Aceptar',
			'language.english' => 'Inglés',
			'language.spanish' => 'Español',
			_ => null,
		};
	}
}
