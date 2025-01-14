abstract class MediplanEvent {}

class MediplanInit extends MediplanEvent {}

class MediplanLoading extends MediplanEvent {}

class TriggerFetchUserData extends MediplanEvent {}

class TriggerMissionUpdate extends MediplanEvent {}

class TriggerMissionSwapDemandsUpdate extends MediplanEvent {}
