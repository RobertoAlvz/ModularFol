Require Export unscoped header_extensible.
Require Export termsyntax.

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
