Require Export unscoped header_extensible.

(* Require Export univ implicative.
 *)

Class Signature := B_S { Funcs : Type; fun_ar : Funcs -> nat ; Preds : Type; pred_ar : Preds -> nat }.
Context {Sigma : Signature}.

Section term.
Inductive term  : Type :=
  | var_term : ( fin ) -> term 
  | Func : forall (f : Funcs), ( vect (fun_ar f) (term  ) ) -> term .

Lemma congr_Func { f : Funcs }  { s0 : vect (fun_ar f) (term  ) } { t0 : vect (fun_ar f) (term  ) } (H1 : s0 = t0) : Func  f s0 = Func  f t0 .
Proof. congruence. Qed.

Fixpoint subst_term   (sigmaterm : ( fin ) -> term ) (s : term ) : term  :=
    match s return term  with
    | var_term  s => sigmaterm s
    | Func  f s0 => Func  f ((vect_map (subst_term sigmaterm)) s0)
    end.

Definition up_term_term   (sigma : ( fin ) -> term ) : ( fin ) -> term  :=
  (scons) ((var_term ) (var_zero)) ((funcomp) (subst_term ((funcomp) (var_term ) (shift))) sigma).

Definition upId_term_term  (sigma : ( fin ) -> term ) (Eq : forall x, sigma x = (var_term ) x) : forall x, (up_term_term sigma) x = (var_term ) x :=
  fun n => match n with
  | S fin_n => (ap) (subst_term ((funcomp) (var_term ) (shift))) (Eq fin_n)
  | 0  => eq_refl
  end.
(* 
Fixpoint idSubst_term  (sigmaterm : ( fin ) -> term ) (Eqterm : forall x, sigmaterm x = (var_term ) x) (s : term ) : subst_term sigmaterm s = s :=
    match s return subst_term sigmaterm s = s with
    | var_term  s => Eqterm s
    | Func  f s0 => congr_Func ((vect_id (idSubst_term sigmaterm Eqterm)) s0)
    end. 

Definition upExt_term_term   (sigma : ( fin ) -> term ) (tau : ( fin ) -> term ) (Eq : forall x, sigma x = tau x) : forall x, (up_term_term sigma) x = (up_term_term tau) x :=
  fun n => match n with
  | S fin_n => (ap) (subst_term ((funcomp) (var_term ) (shift))) (Eq fin_n)
  | 0  => eq_refl
  end.

Fixpoint ext_term   (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (Eqterm : forall x, sigmaterm x = tauterm x) (s : term ) : subst_term sigmaterm s = subst_term tauterm s :=
    match s return subst_term sigmaterm s = subst_term tauterm s with
    | var_term  s => Eqterm s
    | Func  f s0 => congr_Func ((vect_ext (ext_term sigmaterm tauterm Eqterm)) s0)
    end.

Fixpoint compSubstSubst_term    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (thetaterm : ( fin ) -> term ) (Eqterm : forall x, ((funcomp) (subst_term tauterm) sigmaterm) x = thetaterm x) (s : term ) : subst_term tauterm (subst_term sigmaterm s) = subst_term thetaterm s :=
    match s return subst_term tauterm (subst_term sigmaterm s) = subst_term thetaterm s with
    | var_term  s => Eqterm s
    | Func  f s0 => congr_Func ((vect_comp (compSubstSubst_term sigmaterm tauterm thetaterm Eqterm)) s0)
    end.

Definition up_subst_subst_term_term    (sigma : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (theta : ( fin ) -> term ) (Eq : forall x, ((funcomp) (subst_term tauterm) sigma) x = theta x) : forall x, ((funcomp) (subst_term (up_term_term tauterm)) (up_term_term sigma)) x = (up_term_term theta) x :=
  fun n => match n with
  | S fin_n => (eq_trans) (compSubstSubst_term ((funcomp) (var_term ) (shift)) (up_term_term tauterm) ((funcomp) (up_term_term tauterm) (shift)) (fun x => eq_refl) (sigma fin_n)) ((eq_trans) ((eq_sym) (compSubstSubst_term tauterm ((funcomp) (var_term ) (shift)) ((funcomp) (subst_term ((funcomp) (var_term ) (shift))) tauterm) (fun x => eq_refl) (sigma fin_n))) ((ap) (subst_term ((funcomp) (var_term ) (shift))) (Eq fin_n)))
  | 0  => eq_refl
  end.

Lemma instId_term  : subst_term (var_term ) = id .
Proof. exact ((FunctionalExtensionality.functional_extensionality _ _ ) (fun x => idSubst_term (var_term ) (fun n => eq_refl) ((id) x))). Qed.

Lemma varL_term   (sigmaterm : ( fin ) -> term ) : (funcomp) (subst_term sigmaterm) (var_term ) = sigmaterm .
Proof. exact ((FunctionalExtensionality.functional_extensionality _ _ ) (fun x => eq_refl)). Qed.

Lemma compComp_term    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (s : term ) : subst_term tauterm (subst_term sigmaterm s) = subst_term ((funcomp) (subst_term tauterm) sigmaterm) s .
Proof. exact (compSubstSubst_term sigmaterm tauterm (_) (fun n => eq_refl) s). Qed.

Lemma compComp'_term    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) : (funcomp) (subst_term tauterm) (subst_term sigmaterm) = subst_term ((funcomp) (subst_term tauterm) sigmaterm) .
Proof. exact ((FunctionalExtensionality.functional_extensionality _ _ ) (fun n => compComp_term sigmaterm tauterm n)). Qed.
*)
End term.

Section form_univ.
Variable form : Type.

Variable subst_form : forall   (sigmaterm : ( fin ) -> term ) (s : form ), form .

Variable idSubst_form : forall  (sigmaterm : ( fin ) -> term ) (Eqterm : forall x, sigmaterm x = (var_term ) x) (s : form ), subst_form sigmaterm s = s.

Variable ext_form : forall   (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (Eqterm : forall x, sigmaterm x = tauterm x) (s : form ), subst_form sigmaterm s = subst_form tauterm s.

Variable compSubstSubst_form : forall    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (thetaterm : ( fin ) -> term ) (Eqterm : forall x, ((funcomp) (subst_term tauterm) sigmaterm) x = thetaterm x) (s : form ), subst_form tauterm (subst_form sigmaterm s) = subst_form thetaterm s.

Inductive form_univ  : Type :=
  | Pred : forall (p : Preds), ( vect (pred_ar p) (term  ) ) -> form_univ 
  | All : ( form   ) -> form_univ .

Variable retract_form_univ : retract form_univ form.

Definition Pred_  (p : Preds) (s0 : vect (pred_ar p) (term  )) : _ :=
  inj (Pred p s0).

Definition All_  (s0 : form  ) : _ :=
  inj (All s0).

Lemma congr_Pred_ { p : Preds }  { s0 : vect (pred_ar p) (term  ) } { t0 : vect (pred_ar p) (term  ) } (H1 : s0 = t0) : Pred_  p s0 = Pred_  p t0 .
Proof. congruence. Qed.

Lemma congr_All_  { s0 : form   } { t0 : form   } (H1 : s0 = t0) : All_  s0 = All_  t0 .
Proof. congruence. Qed.

(* Variable retract_ren_form : forall   (xiterm : ( fin ) -> fin) s, ren_form xiterm (inj s) = ren_form_univ xiterm s. *)

Definition subst_form_univ   (sigmaterm : ( fin ) -> term ) (s : form_univ ) : form  :=
    match s return form  with
    | Pred  p s0 => Pred_  p ((vect_map (subst_term sigmaterm)) s0)
    | All  s0 => All_  ((subst_form (up_term_term sigmaterm)) s0)
    end.

Variable retract_subst_form : forall   (sigmaterm : ( fin ) -> term ) s, subst_form sigmaterm (inj s) = subst_form_univ sigmaterm s.

(* Definition idSubst_form_univ  (sigmaterm : ( fin ) -> term ) (Eqterm : forall x, sigmaterm x = (var_term ) x) (s : form_univ ) : subst_form_univ sigmaterm s = inj s :=
    match s return subst_form_univ sigmaterm s = inj s with
    | Pred  p s0 => congr_Pred_ ((vect_id (idSubst_term sigmaterm Eqterm)) s0)
    | All  s0 => congr_All_ ((idSubst_form (up_term_term sigmaterm) (upId_term_term (_) Eqterm)) s0)
    end. 

Definition ext_form_univ   (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (Eqterm : forall x, sigmaterm x = tauterm x) (s : form_univ ) : subst_form_univ sigmaterm s = subst_form_univ tauterm s :=
    match s return subst_form_univ sigmaterm s = subst_form_univ tauterm s with
    | Pred  p s0 => congr_Pred_ ((vect_ext (ext_term sigmaterm tauterm Eqterm)) s0)
    | All  s0 => congr_All_ ((ext_form (up_term_term sigmaterm) (up_term_term tauterm) (upExt_term_term (_) (_) Eqterm)) s0)
    end.

Definition compSubstSubst_form_univ    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (thetaterm : ( fin ) -> term ) (Eqterm : forall x, ((funcomp) (subst_term tauterm) sigmaterm) x = thetaterm x) (s : form_univ ) : subst_form tauterm (subst_form_univ sigmaterm s) = subst_form_univ thetaterm s :=
    match s return subst_form tauterm (subst_form_univ sigmaterm s) = subst_form_univ thetaterm s with
    | Pred  p s0 => (eq_trans) (retract_subst_form (_) (Pred (_))) (congr_Pred_ ((vect_comp (compSubstSubst_term sigmaterm tauterm thetaterm Eqterm)) s0))
    | All  s0 => (eq_trans) (retract_subst_form (_) (All (_))) (congr_All_ ((compSubstSubst_form (up_term_term sigmaterm) (up_term_term tauterm) (up_term_term thetaterm) (up_subst_subst_term_term (_) (_) (_) Eqterm)) s0))
    end.

Lemma instId_form_univ  : subst_form_univ (var_term ) = inj .
Proof. exact ((FunctionalExtensionality.functional_extensionality _ _ ) (fun x => idSubst_form_univ (var_term ) (fun n => eq_refl) ((id) x))). Qed.

Lemma compComp_form_univ    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (s : form_univ ) : subst_form tauterm (subst_form_univ sigmaterm s) = subst_form_univ ((funcomp) (subst_term tauterm) sigmaterm) s .
Proof. exact (compSubstSubst_form_univ sigmaterm tauterm (_) (fun n => eq_refl) s). Qed.

Lemma compComp'_form_univ    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) : (funcomp) (subst_form tauterm) (subst_form_univ sigmaterm) = subst_form_univ ((funcomp) (subst_term tauterm) sigmaterm) .
Proof. exact ((FunctionalExtensionality.functional_extensionality _ _ ) (fun n => compComp_form_univ sigmaterm tauterm n)). Qed.

Definition isIn_form_form_univ (s : form) (t : form_univ) : Prop :=
  match t with
  | Pred t0  => False
  | All t0  => s = t0
  end.
*)
End form_univ.

Section form_implicative.
Variable form : Type.

Variable subst_form : forall   (sigmaterm : ( fin ) -> term ) (s : form ), form .

Variable idSubst_form : forall  (sigmaterm : ( fin ) -> term ) (Eqterm : forall x, sigmaterm x = (var_term ) x) (s : form ), subst_form sigmaterm s = s.

Variable ext_form : forall   (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (Eqterm : forall x, sigmaterm x = tauterm x) (s : form ), subst_form sigmaterm s = subst_form tauterm s.

Variable compSubstSubst_form : forall    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (thetaterm : ( fin ) -> term ) (Eqterm : forall x, ((funcomp) (subst_term tauterm) sigmaterm) x = thetaterm x) (s : form ), subst_form tauterm (subst_form sigmaterm s) = subst_form thetaterm s.

Inductive form_implicative  : Type :=
  | Fal : form_implicative 
  | Impl : ( form   ) -> ( form   ) -> form_implicative .

Variable retract_form_implicative : retract form_implicative form.

Definition Fal_  : _ :=
  inj (Fal ).

Definition Impl_  (s0 : form  ) (s1 : form  ) : _ :=
  inj (Impl s0 s1).

Lemma congr_Fal_  : Fal_  = Fal_  .
Proof. congruence. Qed.

Lemma congr_Impl_  { s0 : form   } { s1 : form   } { t0 : form   } { t1 : form   } (H1 : s0 = t0) (H2 : s1 = t1) : Impl_  s0 s1 = Impl_  t0 t1 .
Proof. congruence. Qed.

(* Variable retract_ren_form : forall   (xiterm : ( fin ) -> fin) s, ren_form xiterm (inj s) = ren_form_implicative xiterm s. *)

Definition subst_form_implicative   (sigmaterm : ( fin ) -> term ) (s : form_implicative ) : form  :=
    match s return form  with
    | Fal   => Fal_ 
    | Impl  s0 s1 => Impl_  ((subst_form sigmaterm) s0) ((subst_form sigmaterm) s1)
    end.

Variable retract_subst_form : forall   (sigmaterm : ( fin ) -> term ) s, subst_form sigmaterm (inj s) = subst_form_implicative sigmaterm s.

Definition idSubst_form_implicative  (sigmaterm : ( fin ) -> term ) (Eqterm : forall x, sigmaterm x = (var_term ) x) (s : form_implicative ) : subst_form_implicative sigmaterm s = inj s :=
    match s return subst_form_implicative sigmaterm s = inj s with
    | Fal   => congr_Fal_ 
    | Impl  s0 s1 => congr_Impl_ ((idSubst_form sigmaterm Eqterm) s0) ((idSubst_form sigmaterm Eqterm) s1)
    end.

Definition ext_form_implicative   (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (Eqterm : forall x, sigmaterm x = tauterm x) (s : form_implicative ) : subst_form_implicative sigmaterm s = subst_form_implicative tauterm s :=
    match s return subst_form_implicative sigmaterm s = subst_form_implicative tauterm s with
    | Fal   => congr_Fal_ 
    | Impl  s0 s1 => congr_Impl_ ((ext_form sigmaterm tauterm Eqterm) s0) ((ext_form sigmaterm tauterm Eqterm) s1)
    end.

Definition compSubstSubst_form_implicative    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (thetaterm : ( fin ) -> term ) (Eqterm : forall x, ((funcomp) (subst_term tauterm) sigmaterm) x = thetaterm x) (s : form_implicative ) : subst_form tauterm (subst_form_implicative sigmaterm s) = subst_form_implicative thetaterm s :=
    match s return subst_form tauterm (subst_form_implicative sigmaterm s) = subst_form_implicative thetaterm s with
    | Fal   => (eq_trans) (retract_subst_form (_) (Fal )) (congr_Fal_ )
    | Impl  s0 s1 => (eq_trans) (retract_subst_form (_) (Impl (_) (_))) (congr_Impl_ ((compSubstSubst_form sigmaterm tauterm thetaterm Eqterm) s0) ((compSubstSubst_form sigmaterm tauterm thetaterm Eqterm) s1))
    end.

Lemma instId_form_implicative  : subst_form_implicative (var_term ) = inj .
Proof. exact ((FunctionalExtensionality.functional_extensionality _ _ ) (fun x => idSubst_form_implicative (var_term ) (fun n => eq_refl) ((id) x))). Qed.

Lemma compComp_form_implicative    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (s : form_implicative ) : subst_form tauterm (subst_form_implicative sigmaterm s) = subst_form_implicative ((funcomp) (subst_term tauterm) sigmaterm) s .
Proof. exact (compSubstSubst_form_implicative sigmaterm tauterm (_) (fun n => eq_refl) s). Qed.

Lemma compComp'_form_implicative    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) : (funcomp) (subst_form tauterm) (subst_form_implicative sigmaterm) = subst_form_implicative ((funcomp) (subst_term tauterm) sigmaterm) .
Proof. exact ((FunctionalExtensionality.functional_extensionality _ _ ) (fun n => compComp_form_implicative sigmaterm tauterm n)). Qed.

Definition isIn_form_form_implicative (s : form) (t : form_implicative) : Prop :=
  match t with
  | Fal   => False
  | Impl t0 t1  => or (s = t0) (s = t1)
  end.

End form_implicative.

Section form.
Inductive form  : Type :=
  | In_form_implicative : ( form_implicative form  ) -> form 
  | In_form_univ : ( form_univ form  ) -> form .

Lemma congr_In_form_implicative  { s0 : form_implicative form  } { t0 : form_implicative form  } (H1 : s0 = t0) : In_form_implicative  s0 = In_form_implicative  t0 .
Proof. congruence. Qed.

Lemma congr_In_form_univ  { s0 : form_univ form  } { t0 : form_univ form  } (H1 : s0 = t0) : In_form_univ  s0 = In_form_univ  t0 .
Proof. congruence. Qed.

Global Instance retract_form_univ_form  : retract (form_univ form) form := Build_retract In_form_univ (fun x => match x with
| In_form_univ s  => Datatypes.Some s
| _ => Datatypes.None
end) (fun s => eq_refl) (fun s t => match t with
| In_form_univ t'  => fun H => congr_In_form_univ ((eq_sym) (Some_inj H))
| _ => some_none_explosion
end) .

Global Instance retract_form_implicative_form  : retract (form_implicative form) form := Build_retract In_form_implicative (fun x => match x with
| In_form_implicative s  => Datatypes.Some s
| _ => Datatypes.None
end) (fun s => eq_refl) (fun s t => match t with
| In_form_implicative t'  => fun H => congr_In_form_implicative ((eq_sym) (Some_inj H))
| _ => some_none_explosion
end) .

Check subst_form_implicative.

Fixpoint subst_form   (sigmaterm : ( fin ) -> term ) (s : form ) : form  :=
    match s return form  with
    | In_form_implicative  s0 =>   subst_form_implicative form subst_form _ sigmaterm s0
    | In_form_univ  s0 =>   ((subst_form_univ form subst_form _ sigmaterm) s0)
    end.
(*
Fixpoint idSubst_form  (sigmaterm : ( fin ) -> term ) (Eqterm : forall x, sigmaterm x = (var_term ) x) (s : form ) : subst_form sigmaterm s = s :=
    match s return subst_form sigmaterm s = s with
    | In_form_implicative  s0 =>  ((idSubst_form_implicative form sigmaterm Eqterm) s0)
    | In_form_univ  s0 =>  ((idSubst_form_univ form up_term_form upId_term_form sigmaterm Eqterm) s0)
    end.

Fixpoint ext_form   (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (Eqterm : forall x, sigmaterm x = tauterm x) (s : form ) : subst_form sigmaterm s = subst_form tauterm s :=
    match s return subst_form sigmaterm s = subst_form tauterm s with
    | In_form_implicative  s0 =>  ((ext_form_implicative form sigmaterm tauterm Eqterm) s0)
    | In_form_univ  s0 =>  ((ext_form_univ form up_term_form upExt_term_form sigmaterm tauterm Eqterm) s0)
    end.
Fixpoint compSubstSubst_form    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (thetaterm : ( fin ) -> term ) (Eqterm : forall x, ((funcomp) (subst_term tauterm) sigmaterm) x = thetaterm x) (s : form ) : subst_form tauterm (subst_form sigmaterm s) = subst_form thetaterm s :=
    match s return subst_form tauterm (subst_form sigmaterm s) = subst_form thetaterm s with
    | In_form_implicative  s0 =>  ((compSubstSubst_form_implicative form sigmaterm tauterm thetaterm Eqterm) s0)
    | In_form_univ  s0 =>  ((compSubstSubst_form_univ form up_term_form up_subst_subst_term_form sigmaterm tauterm thetaterm Eqterm) s0)
    end.

Lemma instId_form  : subst_form (var_term ) = id .
Proof. exact ((FunctionalExtensionality.functional_extensionality _ _ ) (fun x => idSubst_form (var_term ) (fun n => eq_refl) ((id) x))). Qed.

Lemma compComp_form    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) (s : form ) : subst_form tauterm (subst_form sigmaterm s) = subst_form ((funcomp) (subst_term tauterm) sigmaterm) s .
Proof. exact (compSubstSubst_form sigmaterm tauterm (_) (fun n => eq_refl) s). Qed.

Lemma compComp'_form    (sigmaterm : ( fin ) -> term ) (tauterm : ( fin ) -> term ) : (funcomp) (subst_form tauterm) (subst_form sigmaterm) = subst_form ((funcomp) (subst_term tauterm) sigmaterm) .
Proof. exact ((FunctionalExtensionality.functional_extensionality _ _ ) (fun n => compComp_form sigmaterm tauterm n)). Qed.

*)
End form.



















Global Instance Subst_term   : Subst1 (( fin ) -> term ) (term ) (term ) := @subst_term   .

Global Instance Subst_form   : Subst1 (( fin ) -> term ) (form ) (form ) := @subst_form   .

Global Instance VarInstance_term  : Var (fin) (term ) := @var_term  .

Notation "x '__term'" := (var_term x) (at level 5, format "x __term") : subst_scope.

Notation "x '__term'" := (@ids (_) (_) VarInstance_term x) (at level 5, only printing, format "x __term") : subst_scope.

Notation "'var'" := (var_term) (only printing, at level 1) : subst_scope.

Class Up_term X Y := up_term : ( X ) -> Y.

Notation "↑__term" := (up_term) (only printing) : subst_scope.

Notation "↑__term" := (up_term_term) (only printing) : subst_scope.

Global Instance Up_term_term   : Up_term (_) (_) := @up_term_term   .

Notation "s [ sigmaterm ]" := (subst_term sigmaterm s) (at level 7, left associativity, only printing) : subst_scope.

Notation "[ sigmaterm ]" := (subst_term sigmaterm) (at level 1, left associativity, only printing) : fscope.

Notation "s [ sigmaterm ]" := (subst_form_univ sigmaterm s) (at level 7, left associativity, only printing) : subst_scope.

Notation "[ sigmaterm ]" := (subst_form_univ sigmaterm) (at level 1, left associativity, only printing) : fscope.

Notation "s [ sigmaterm ]" := (subst_form_implicative sigmaterm s) (at level 7, left associativity, only printing) : subst_scope.

Notation "[ sigmaterm ]" := (subst_form_implicative sigmaterm) (at level 1, left associativity, only printing) : fscope.

Notation "s [ sigmaterm ]" := (subst_form sigmaterm s) (at level 7, left associativity, only printing) : subst_scope.

Notation "[ sigmaterm ]" := (subst_form sigmaterm) (at level 1, left associativity, only printing) : fscope.

Ltac auto_unfold := repeat unfold subst1,  subst2,  Subst1,  Subst2,  ids,  ren1,  ren2,  Ren1,  Ren2,  Subst_term,  Subst_form,  VarInstance_term.

Tactic Notation "auto_unfold" "in" "*" := repeat unfold subst1,  subst2,  Subst1,  Subst2,  ids,  ren1,  ren2,  Ren1,  Ren2,  Subst_term,  Subst_form,  VarInstance_term in *.
(*** 
Ltac asimpl' := repeat first [progress rewrite ?instId_term| progress rewrite ?compComp_term| progress rewrite ?compComp'_term| progress rewrite ?instId_form_univ| progress rewrite ?compComp_form_univ| progress rewrite ?compComp'_form_univ| progress rewrite ?instId_form_implicative| progress rewrite ?compComp_form_implicative| progress rewrite ?compComp'_form_implicative| progress rewrite ?instId_form| progress rewrite ?compComp_form| progress rewrite ?compComp'_form| progress rewrite ?varL_term| progress (unfold up_ren, up_term_term)| progress (cbn [subst_term subst_form_univ subst_form_implicative subst_form])| fsimpl].

Ltac asimpl := repeat try unfold_funcomp; auto_unfold in *; asimpl'; repeat try unfold_funcomp.

Tactic Notation "asimpl" "in" hyp(J) := revert J; asimpl; intros J.

Tactic Notation "auto_case" := auto_case (asimpl; cbn; eauto).

Tactic Notation "asimpl" "in" "*" := auto_unfold in *; repeat first [progress rewrite ?instId_term in *| progress rewrite ?compComp_term in *| progress rewrite ?compComp'_term in *| progress rewrite ?instId_form_univ in *| progress rewrite ?compComp_form_univ in *| progress rewrite ?compComp'_form_univ in *| progress rewrite ?instId_form_implicative in *| progress rewrite ?compComp_form_implicative in *| progress rewrite ?compComp'_form_implicative in *| progress rewrite ?instId_form in *| progress rewrite ?compComp_form in *| progress rewrite ?compComp'_form in *| progress rewrite ?varL_term in *| progress (unfold up_ren, up_term_term in * )| progress (cbn [subst_term subst_form_univ subst_form_implicative subst_form] in * )| fsimpl in *].
 ***)
Ltac substify := auto_unfold.

Ltac renamify := auto_unfold.

