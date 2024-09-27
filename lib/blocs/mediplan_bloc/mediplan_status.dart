abstract class MediplanStatus {
  const MediplanStatus();
}

class MediplanInitialStatus extends MediplanStatus {
  const MediplanInitialStatus();
}

class MediplanLoadingStatus extends MediplanStatus {}

class MediplanErrorStatus extends MediplanStatus {
  final Exception exception;

  MediplanErrorStatus(this.exception);
}

class MediplanSuccessStatus extends MediplanStatus {}
