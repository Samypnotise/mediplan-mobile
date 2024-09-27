abstract class MediplanEvent {}

class MediplanInit extends MediplanEvent {}

class MediplanLoading extends MediplanEvent {}

class TriggerDeadlineUpdate extends MediplanEvent {}

class TriggerSubjectUpdate extends MediplanEvent {}

class TriggerLessonUpdate extends MediplanEvent {}

class TriggerFlashcardUpdate extends MediplanEvent {}

class TriggerStudySessionUpdate extends MediplanEvent {}

class TriggerSettingsUpdate extends MediplanEvent {}

class TriggerJMethodUpdate extends MediplanEvent {}
